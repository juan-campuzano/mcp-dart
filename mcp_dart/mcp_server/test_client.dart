#!/usr/bin/env dart

import 'dart:convert';
import 'dart:io';

/// Cliente simple para probar el servidor MCP
void main() async {
  print('Cliente MCP - Probando conexión...');

  // Crear proceso del servidor MCP
  final process = await Process.start(
    'dart',
    ['run', 'bin/mcp_dart_server.dart'],
    workingDirectory: '/Users/jcampuza/Documents/GitHub/mcp_dart/mcp_server',
  );

  // Configurar streams
  process.stdout.transform(utf8.decoder).listen((data) {
    print('Servidor: $data');
  });

  process.stderr.transform(utf8.decoder).listen((data) {
    print('Error servidor: $data');
  });

  // Enviar mensaje de inicialización
  final initRequest = {
    'jsonrpc': '2.0',
    'id': 1,
    'method': 'initialize',
    'params': {
      'protocolVersion': '2024-11-05',
      'capabilities': {'tools': {}},
      'clientInfo': {'name': 'Test Client', 'version': '1.0.0'}
    }
  };

  print('Enviando inicialización...');
  process.stdin.writeln(jsonEncode(initRequest));

  // Esperar un poco
  await Future.delayed(Duration(seconds: 2));

  // Enviar solicitud de herramientas disponibles
  final toolsRequest = {
    'jsonrpc': '2.0',
    'id': 2,
    'method': 'tools/list',
    'params': {}
  };

  print('Solicitando lista de herramientas...');
  process.stdin.writeln(jsonEncode(toolsRequest));

  // Esperar un poco más
  await Future.delayed(Duration(seconds: 2));

  // Probar la herramienta de cálculo
  final calcRequest = {
    'jsonrpc': '2.0',
    'id': 3,
    'method': 'tools/call',
    'params': {
      'name': 'calculate',
      'arguments': {'expression': '2 + 2 * 3'}
    }
  };

  print('Probando cálculo: 2 + 2 * 3');
  process.stdin.writeln(jsonEncode(calcRequest));

  // Esperar respuesta
  await Future.delayed(Duration(seconds: 3));

  print('Cerrando cliente...');
  process.kill();
}
