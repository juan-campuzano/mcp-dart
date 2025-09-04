/// Base class for all MCP messages
class MCPMessage {
  final String jsonrpc;
  final dynamic id;

  const MCPMessage({
    this.jsonrpc = '2.0',
    this.id,
  });

  factory MCPMessage.fromJson(Map<String, dynamic> json) {
    return MCPMessage(
      jsonrpc: json['jsonrpc'] ?? '2.0',
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jsonrpc': jsonrpc,
      if (id != null) 'id': id,
    };
  }
}

/// MCP Request message
class MCPRequest extends MCPMessage {
  final String method;
  final Map<String, dynamic>? params;

  const MCPRequest({
    required this.method,
    this.params,
    super.id,
    super.jsonrpc = '2.0',
  });

  factory MCPRequest.fromJson(Map<String, dynamic> json) {
    return MCPRequest(
      method: json['method'],
      params: json['params']?.cast<String, dynamic>(),
      id: json['id'],
      jsonrpc: json['jsonrpc'] ?? '2.0',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final result = super.toJson();
    result['method'] = method;
    if (params != null) result['params'] = params;
    return result;
  }
}

/// MCP Response message
class MCPResponse extends MCPMessage {
  final dynamic result;
  final MCPError? error;

  const MCPResponse({
    this.result,
    this.error,
    required super.id,
    super.jsonrpc = '2.0',
  });

  factory MCPResponse.fromJson(Map<String, dynamic> json) {
    return MCPResponse(
      result: json['result'],
      error: json['error'] != null ? MCPError.fromJson(json['error']) : null,
      id: json['id'],
      jsonrpc: json['jsonrpc'] ?? '2.0',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final result = super.toJson();
    if (this.result != null) result['result'] = this.result;
    if (error != null) result['error'] = error!.toJson();
    return result;
  }
}

/// MCP Error
class MCPError {
  final int code;
  final String message;
  final dynamic data;

  const MCPError({
    required this.code,
    required this.message,
    this.data,
  });

  factory MCPError.fromJson(Map<String, dynamic> json) {
    return MCPError(
      code: json['code'],
      message: json['message'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      if (data != null) 'data': data,
    };
  }
}

/// MCP Tool definition
class MCPTool {
  final String name;
  final String description;
  final Map<String, dynamic> inputSchema;

  const MCPTool({
    required this.name,
    required this.description,
    required this.inputSchema,
  });

  factory MCPTool.fromJson(Map<String, dynamic> json) {
    return MCPTool(
      name: json['name'],
      description: json['description'],
      inputSchema: json['inputSchema']?.cast<String, dynamic>() ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'inputSchema': inputSchema,
    };
  }
}

/// MCP Resource definition
class MCPResource {
  final String uri;
  final String name;
  final String? description;
  final String? mimeType;

  const MCPResource({
    required this.uri,
    required this.name,
    this.description,
    this.mimeType,
  });

  factory MCPResource.fromJson(Map<String, dynamic> json) {
    return MCPResource(
      uri: json['uri'],
      name: json['name'],
      description: json['description'],
      mimeType: json['mimeType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uri': uri,
      'name': name,
      if (description != null) 'description': description,
      if (mimeType != null) 'mimeType': mimeType,
    };
  }
}

/// MCP Server capabilities
class MCPServerCapabilities {
  final bool? logging;
  final bool? tools;
  final bool? resources;
  final bool? prompts;

  const MCPServerCapabilities({
    this.logging,
    this.tools,
    this.resources,
    this.prompts,
  });

  factory MCPServerCapabilities.fromJson(Map<String, dynamic> json) {
    return MCPServerCapabilities(
      logging: json['logging'],
      tools: json['tools'],
      resources: json['resources'],
      prompts: json['prompts'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (logging != null) 'logging': logging,
      if (tools != null) 'tools': tools,
      if (resources != null) 'resources': resources,
      if (prompts != null) 'prompts': prompts,
    };
  }
}

/// MCP Server info
class MCPServerInfo {
  final String name;
  final String version;
  final MCPServerCapabilities capabilities;

  const MCPServerInfo({
    required this.name,
    required this.version,
    required this.capabilities,
  });

  factory MCPServerInfo.fromJson(Map<String, dynamic> json) {
    return MCPServerInfo(
      name: json['name'],
      version: json['version'],
      capabilities: MCPServerCapabilities.fromJson(json['capabilities']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'version': version,
      'capabilities': capabilities.toJson(),
    };
  }
}

/// Tool call arguments
class ToolCallArguments {
  final String name;
  final Map<String, dynamic> arguments;

  const ToolCallArguments({
    required this.name,
    required this.arguments,
  });

  factory ToolCallArguments.fromJson(Map<String, dynamic> json) {
    return ToolCallArguments(
      name: json['name'],
      arguments: json['arguments']?.cast<String, dynamic>() ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'arguments': arguments,
    };
  }
}

/// Tool result
class ToolResult {
  final List<Map<String, dynamic>> content;
  final bool? isError;

  const ToolResult({
    required this.content,
    this.isError,
  });

  factory ToolResult.fromJson(Map<String, dynamic> json) {
    return ToolResult(
      content: (json['content'] as List?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          [],
      isError: json['isError'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      if (isError != null) 'isError': isError,
    };
  }
}

/// Error codes as defined by MCP
class MCPErrorCodes {
  static const int parseError = -32700;
  static const int invalidRequest = -32600;
  static const int methodNotFound = -32601;
  static const int invalidParams = -32602;
  static const int internalError = -32603;
  static const int serverNotInitialized = -32002;
  static const int unknownErrorCode = -32001;
}
