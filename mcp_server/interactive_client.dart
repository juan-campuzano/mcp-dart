#!/usr/bin/env dart

import 'dart:convert';
import 'dart:io';

/// Cliente interactivo para probar el servidor MCP
void main() async {
  print('🚀 Cliente MCP Interactivo');
  print('═══════════════════════════');

  // Iniciar el servidor en background
  final server = await Process.start(
    'dart',
    ['run'],
    workingDirectory: '/Users/jcampuza/Documents/GitHub/mcp_dart/mcp_server',
  );

  print('✅ Servidor iniciado');

  // Escuchar respuestas del servidor
  server.stdout.transform(utf8.decoder).listen((data) {
    final lines = data.split('\n');
    for (final line in lines) {
      if (line.trim().isNotEmpty && line.startsWith('{')) {
        try {
          final response = jsonDecode(line);
          print('📨 Respuesta: ${jsonEncode(response)}');
        } catch (e) {
          print('📄 Log: $line');
        }
      } else if (line.trim().isNotEmpty) {
        print('📄 Log: $line');
      }
    }
  });

  server.stderr.transform(utf8.decoder).listen((data) {
    print('❌ Error: $data');
  });

  // Esperar a que el servidor esté listo
  await Future.delayed(Duration(seconds: 2));

  print('\n🔧 Enviando comandos de prueba...\n');

  // 1. Inicializar
  await sendRequest(server, {
    'jsonrpc': '2.0',
    'id': 1,
    'method': 'initialize',
    'params': {
      'protocolVersion': '2024-11-05',
      'capabilities': {'tools': {}},
      'clientInfo': {'name': 'Interactive Client', 'version': '1.0.0'}
    }
  });

  await Future.delayed(Duration(seconds: 1));

  // 2. Listar herramientas
  await sendRequest(server,
      {'jsonrpc': '2.0', 'id': 2, 'method': 'tools/list', 'params': {}});

  await Future.delayed(Duration(seconds: 1));

  // 3. Probar calculadora
  await sendRequest(server, {
    'jsonrpc': '2.0',
    'id': 3,
    'method': 'tools/call',
    'params': {
      'name': 'calculate',
      'arguments': {'expression': '10 + 5 * 2'}
    }
  });

  await Future.delayed(Duration(seconds: 1));

  // 4. Obtener hora actual
  await sendRequest(server, {
    'jsonrpc': '2.0',
    'id': 4,
    'method': 'tools/call',
    'params': {'name': 'current_time', 'arguments': {}}
  });

  await Future.delayed(Duration(seconds: 1));

  // 5. Generar número aleatorio
  await sendRequest(server, {
    'jsonrpc': '2.0',
    'id': 5,
    'method': 'tools/call',
    'params': {
      'name': 'generate_random',
      'arguments': {'min': 1, 'max': 100}
    }
  });

  // Esperar respuestas finales
  await Future.delayed(Duration(seconds: 3));

  print('\n✅ Prueba completada. Presiona Ctrl+C para salir.');

  // Mantener el cliente vivo
  await Future.delayed(Duration(seconds: 30));

  server.kill();
}

Future<void> sendRequest(Process server, Map<String, dynamic> request) async {
  final json = jsonEncode(request);
  print('📤 Enviando: ${request['method']} (id: ${request['id']})');
  server.stdin.writeln(json);
}
