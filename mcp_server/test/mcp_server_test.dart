import 'package:test/test.dart';
import '../lib/mcp_protocol.dart';
import '../bin/mcp_dart_server.dart';

void main() {
  group('MCP Server Tests', () {
    late ExampleMCPServer server;

    setUp(() {
      server = ExampleMCPServer();
    });

    test('should initialize server with tools', () {
      expect(server.tools.length, equals(6));
      expect(server.tools.any((tool) => tool.name == 'calculate'), isTrue);
      expect(server.tools.any((tool) => tool.name == 'list_files'), isTrue);
      expect(server.tools.any((tool) => tool.name == 'read_file'), isTrue);
      expect(server.tools.any((tool) => tool.name == 'write_file'), isTrue);
      expect(server.tools.any((tool) => tool.name == 'current_time'), isTrue);
      expect(
          server.tools.any((tool) => tool.name == 'generate_random'), isTrue);
    });

    test('should calculate math expressions', () async {
      final result =
          await server.callTool('calculate', {'expression': '2 + 2'});
      expect(result.content.first['text'], contains('4'));
    });

    test('should handle invalid math expressions', () async {
      final result = await server.callTool('calculate', {'expression': '2 +'});
      expect(result.isError, isTrue);
    });

    test('should generate current time', () async {
      final result = await server.callTool('current_time', {});
      expect(result.content.first['text'], contains('Hora actual'));
    });

    test('should generate random numbers', () async {
      final result =
          await server.callTool('generate_random', {'min': 1, 'max': 10});
      expect(result.content.first['text'], contains('aleatorio'));
    });

    test('should list resources', () {
      expect(server.resources.length, equals(1));
      expect(server.resources[0].uri, equals('info://server'));
    });
  });

  group('MCP Protocol Tests', () {
    test('should create valid MCP request', () {
      final request = MCPRequest(
        jsonrpc: '2.0',
        id: 1,
        method: 'tools/list',
        params: {},
      );

      final json = request.toJson();
      expect(json['jsonrpc'], equals('2.0'));
      expect(json['id'], equals(1));
      expect(json['method'], equals('tools/list'));
    });

    test('should create valid MCP response', () {
      final response = MCPResponse(
        jsonrpc: '2.0',
        id: 1,
        result: {'tools': []},
      );

      final json = response.toJson();
      expect(json['jsonrpc'], equals('2.0'));
      expect(json['id'], equals(1));
      expect(json['result'], isNotNull);
    });

    test('should create valid MCP error', () {
      final error = MCPError(
        code: -32600,
        message: 'Invalid Request',
      );

      final json = error.toJson();
      expect(json['code'], equals(-32600));
      expect(json['message'], equals('Invalid Request'));
    });
  });
}
