import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'mcp_protocol.dart';

/// Abstract base class for MCP Server implementations
abstract class MCPServer {
  bool _initialized = false;
  MCPServerInfo? _serverInfo;

  final Map<String, MCPTool> _tools = {};
  final Map<String, MCPResource> _resources = {};

  /// Server information
  MCPServerInfo get serverInfo => _serverInfo!;

  /// Whether the server has been initialized
  bool get isInitialized => _initialized;

  /// Initialize the server with capabilities
  void initialize({
    required String name,
    required String version,
    bool enableLogging = true,
    bool enableTools = true,
    bool enableResources = true,
    bool enablePrompts = false,
  }) {
    _serverInfo = MCPServerInfo(
      name: name,
      version: version,
      capabilities: MCPServerCapabilities(
        logging: enableLogging,
        tools: enableTools,
        resources: enableResources,
        prompts: enablePrompts,
      ),
    );
    _initialized = true;
    print('MCP Server initialized: $name v$version');
  }

  /// Register a tool
  void registerTool(MCPTool tool) {
    if (!isInitialized) {
      throw StateError('Server must be initialized before registering tools');
    }
    _tools[tool.name] = tool;
    print('Registered tool: ${tool.name}');
  }

  /// Register a resource
  void registerResource(MCPResource resource) {
    if (!isInitialized) {
      throw StateError(
          'Server must be initialized before registering resources');
    }
    _resources[resource.uri] = resource;
    print('Registered resource: ${resource.name} (${resource.uri})');
  }

  /// Get all registered tools
  List<MCPTool> get tools => _tools.values.toList();

  /// Get all registered resources
  List<MCPResource> get resources => _resources.values.toList();

  /// Handle incoming MCP request
  Future<MCPResponse> handleRequest(MCPRequest request) async {
    try {
      print('Handling request: ${request.method}');

      switch (request.method) {
        case 'initialize':
          return _handleInitialize(request);
        case 'tools/list':
          return _handleToolsList(request);
        case 'tools/call':
          return _handleToolsCall(request);
        case 'resources/list':
          return _handleResourcesList(request);
        case 'resources/read':
          return _handleResourcesRead(request);
        default:
          return MCPResponse(
            id: request.id,
            error: MCPError(
              code: MCPErrorCodes.methodNotFound,
              message: 'Method not found: ${request.method}',
            ),
          );
      }
    } catch (e, stackTrace) {
      print('Error handling request: $e\n$stackTrace');
      return MCPResponse(
        id: request.id,
        error: MCPError(
          code: MCPErrorCodes.internalError,
          message: 'Internal server error: $e',
        ),
      );
    }
  }

  MCPResponse _handleInitialize(MCPRequest request) {
    if (!isInitialized) {
      return MCPResponse(
        id: request.id,
        error: MCPError(
          code: MCPErrorCodes.serverNotInitialized,
          message: 'Server not initialized',
        ),
      );
    }

    return MCPResponse(
      id: request.id,
      result: serverInfo.toJson(),
    );
  }

  MCPResponse _handleToolsList(MCPRequest request) {
    return MCPResponse(
      id: request.id,
      result: {
        'tools': tools.map((tool) => tool.toJson()).toList(),
      },
    );
  }

  Future<MCPResponse> _handleToolsCall(MCPRequest request) async {
    final params = request.params;
    if (params == null || params['name'] == null) {
      return MCPResponse(
        id: request.id,
        error: MCPError(
          code: MCPErrorCodes.invalidParams,
          message: 'Missing tool name',
        ),
      );
    }

    final toolName = params['name'] as String;
    final arguments = params['arguments'] as Map<String, dynamic>? ?? {};

    final tool = _tools[toolName];
    if (tool == null) {
      return MCPResponse(
        id: request.id,
        error: MCPError(
          code: MCPErrorCodes.methodNotFound,
          message: 'Tool not found: $toolName',
        ),
      );
    }

    try {
      final result = await callTool(toolName, arguments);
      return MCPResponse(
        id: request.id,
        result: result.toJson(),
      );
    } catch (e) {
      return MCPResponse(
        id: request.id,
        error: MCPError(
          code: MCPErrorCodes.internalError,
          message: 'Tool execution failed: $e',
        ),
      );
    }
  }

  MCPResponse _handleResourcesList(MCPRequest request) {
    return MCPResponse(
      id: request.id,
      result: {
        'resources': resources.map((resource) => resource.toJson()).toList(),
      },
    );
  }

  Future<MCPResponse> _handleResourcesRead(MCPRequest request) async {
    final params = request.params;
    if (params == null || params['uri'] == null) {
      return MCPResponse(
        id: request.id,
        error: MCPError(
          code: MCPErrorCodes.invalidParams,
          message: 'Missing resource URI',
        ),
      );
    }

    final uri = params['uri'] as String;
    final resource = _resources[uri];
    if (resource == null) {
      return MCPResponse(
        id: request.id,
        error: MCPError(
          code: MCPErrorCodes.methodNotFound,
          message: 'Resource not found: $uri',
        ),
      );
    }

    try {
      final content = await readResource(uri);
      return MCPResponse(
        id: request.id,
        result: {
          'contents': [
            {
              'uri': uri,
              'mimeType': resource.mimeType ?? 'text/plain',
              'text': content,
            }
          ],
        },
      );
    } catch (e) {
      return MCPResponse(
        id: request.id,
        error: MCPError(
          code: MCPErrorCodes.internalError,
          message: 'Failed to read resource: $e',
        ),
      );
    }
  }

  /// Abstract method to implement tool execution
  Future<ToolResult> callTool(String name, Map<String, dynamic> arguments);

  /// Abstract method to implement resource reading
  Future<String> readResource(String uri);
}

/// Stdio-based MCP Server implementation
class StdioMCPServer extends MCPServer {
  bool _running = false;
  StreamSubscription<String>? _inputSubscription;

  /// Start the server listening on stdin/stdout
  Future<void> start() async {
    if (_running) {
      throw StateError('Server is already running');
    }

    _running = true;
    print('Starting MCP Server on stdio');

    // Listen to stdin for JSON-RPC messages
    _inputSubscription = stdin
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen(_handleInput);

    // Keep the server running
    while (_running) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  /// Stop the server
  Future<void> stop() async {
    _running = false;
    await _inputSubscription?.cancel();
    print('MCP Server stopped');
  }

  void _handleInput(String line) async {
    if (line.trim().isEmpty) return;

    try {
      final json = jsonDecode(line) as Map<String, dynamic>;
      final request = MCPRequest.fromJson(json);
      final response = await handleRequest(request);

      // Send response to stdout
      stdout.writeln(jsonEncode(response.toJson()));
    } catch (e) {
      print('Failed to parse request: $e');
      // Send parse error response
      final errorResponse = MCPResponse(
        id: null,
        error: MCPError(
          code: MCPErrorCodes.parseError,
          message: 'Parse error: $e',
        ),
      );
      stdout.writeln(jsonEncode(errorResponse.toJson()));
    }
  }

  /// Default tool implementation - override in subclasses
  @override
  Future<ToolResult> callTool(
      String name, Map<String, dynamic> arguments) async {
    return ToolResult(
      content: [
        {
          'type': 'text',
          'text': 'Tool "$name" not implemented',
        }
      ],
      isError: true,
    );
  }

  /// Default resource implementation - override in subclasses
  @override
  Future<String> readResource(String uri) async {
    if (uri.startsWith('file://')) {
      final path = uri.substring(7);
      final file = File(path);
      if (await file.exists()) {
        return await file.readAsString();
      } else {
        throw FileSystemException('File not found', path);
      }
    }
    throw UnsupportedError('Unsupported resource URI: $uri');
  }
}
