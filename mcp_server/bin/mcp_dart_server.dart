import 'dart:io';
import 'dart:math' as math;
import '../lib/mcp_server.dart';
import '../lib/mcp_protocol.dart';

/// Example MCP Server que provee herramientas matemáticas y de archivos
class ExampleMCPServer extends StdioMCPServer {
  ExampleMCPServer() : super() {
    // Inicializar primero
    initialize(
      name: 'Dart MCP Example Server',
      version: '1.0.0',
      enableTools: true,
      enableResources: true,
    );

    // Luego registrar herramientas y recursos
    _registerTools();
    _registerResources();
  }

  void _registerTools() {
    // Registrar herramienta de cálculo matemático
    registerTool(MCPTool(
      name: 'calculate',
      description:
          'Evalúa expresiones matemáticas simples como 2+2, 10*5, etc.',
      inputSchema: {
        'type': 'object',
        'properties': {
          'expression': {
            'type': 'string',
            'description': 'La expresión matemática a evaluar',
          },
        },
        'required': ['expression'],
      },
    ));

    // Registrar herramienta para listar archivos
    registerTool(MCPTool(
      name: 'list_files',
      description: 'Lista los archivos en un directorio específico',
      inputSchema: {
        'type': 'object',
        'properties': {
          'path': {
            'type': 'string',
            'description': 'El path del directorio a listar',
          },
        },
        'required': ['path'],
      },
    ));

    // Registrar herramienta para leer archivos
    registerTool(MCPTool(
      name: 'read_file',
      description: 'Lee el contenido de un archivo',
      inputSchema: {
        'type': 'object',
        'properties': {
          'path': {
            'type': 'string',
            'description': 'El path del archivo a leer',
          },
        },
        'required': ['path'],
      },
    ));

    // Registrar herramienta para escribir archivos
    registerTool(MCPTool(
      name: 'write_file',
      description: 'Escribe contenido a un archivo',
      inputSchema: {
        'type': 'object',
        'properties': {
          'path': {
            'type': 'string',
            'description': 'El path del archivo a escribir',
          },
          'content': {
            'type': 'string',
            'description': 'El contenido a escribir en el archivo',
          },
        },
        'required': ['path', 'content'],
      },
    ));

    // Registrar herramienta para obtener tiempo actual
    registerTool(MCPTool(
      name: 'current_time',
      description: 'Obtiene la fecha y hora actual',
      inputSchema: {
        'type': 'object',
        'properties': {},
      },
    ));

    // Registrar herramienta para generar números aleatorios
    registerTool(MCPTool(
      name: 'generate_random',
      description: 'Genera números aleatorios',
      inputSchema: {
        'type': 'object',
        'properties': {
          'min': {
            'type': 'integer',
            'description': 'Valor mínimo (por defecto: 0)',
          },
          'max': {
            'type': 'integer',
            'description': 'Valor máximo (por defecto: 100)',
          },
          'count': {
            'type': 'integer',
            'description': 'Cantidad de números a generar (por defecto: 1)',
          },
        },
      },
    ));
  }

  void _registerResources() {
    // Registrar algunos recursos de ejemplo
    registerResource(MCPResource(
      uri: 'info://server',
      name: 'Server Information',
      description: 'Información sobre este servidor MCP',
      mimeType: 'text/plain',
    ));
  }

  @override
  Future<ToolResult> callTool(
      String name, Map<String, dynamic> arguments) async {
    switch (name) {
      case 'calculate':
        return _handleCalculate(arguments);
      case 'list_files':
        return _handleListFiles(arguments);
      case 'read_file':
        return _handleReadFile(arguments);
      case 'write_file':
        return _handleWriteFile(arguments);
      case 'current_time':
        return _handleCurrentTime(arguments);
      case 'generate_random':
        return _handleGenerateRandom(arguments);
      default:
        return ToolResult(
          content: [
            {
              'type': 'text',
              'text': 'Tool "$name" no está implementado',
            }
          ],
          isError: true,
        );
    }
  }

  ToolResult _handleCalculate(Map<String, dynamic> arguments) {
    try {
      final expression = arguments['expression'] as String?;
      if (expression == null) {
        return ToolResult(
          content: [
            {
              'type': 'text',
              'text': 'Error: Se requiere el parámetro "expression"',
            }
          ],
          isError: true,
        );
      }

      // Calculadora simple - solo suma, resta, multiplicación, división
      final result = _evaluateExpression(expression);

      return ToolResult(
        content: [
          {
            'type': 'text',
            'text': 'Resultado de "$expression" = $result',
          }
        ],
      );
    } catch (e) {
      return ToolResult(
        content: [
          {
            'type': 'text',
            'text': 'Error calculando: $e',
          }
        ],
        isError: true,
      );
    }
  }

  ToolResult _handleListFiles(Map<String, dynamic> arguments) {
    try {
      final path = arguments['path'] as String? ?? '.';
      final directory = Directory(path);

      if (!directory.existsSync()) {
        return ToolResult(
          content: [
            {
              'type': 'text',
              'text': 'Error: El directorio "$path" no existe',
            }
          ],
          isError: true,
        );
      }

      final files = directory
          .listSync()
          .map((entity) => entity.path.split('/').last)
          .toList();

      return ToolResult(
        content: [
          {
            'type': 'text',
            'text': 'Archivos en "$path":\n${files.join('\n')}',
          }
        ],
      );
    } catch (e) {
      return ToolResult(
        content: [
          {
            'type': 'text',
            'text': 'Error listando archivos: $e',
          }
        ],
        isError: true,
      );
    }
  }

  ToolResult _handleReadFile(Map<String, dynamic> arguments) {
    try {
      final path = arguments['path'] as String?;
      if (path == null) {
        return ToolResult(
          content: [
            {
              'type': 'text',
              'text': 'Error: Se requiere el parámetro "path"',
            }
          ],
          isError: true,
        );
      }

      final file = File(path);
      if (!file.existsSync()) {
        return ToolResult(
          content: [
            {
              'type': 'text',
              'text': 'Error: El archivo "$path" no existe',
            }
          ],
          isError: true,
        );
      }

      final content = file.readAsStringSync();
      return ToolResult(
        content: [
          {
            'type': 'text',
            'text': 'Contenido de "$path":\n\n$content',
          }
        ],
      );
    } catch (e) {
      return ToolResult(
        content: [
          {
            'type': 'text',
            'text': 'Error leyendo archivo: $e',
          }
        ],
        isError: true,
      );
    }
  }

  ToolResult _handleWriteFile(Map<String, dynamic> arguments) {
    try {
      final path = arguments['path'] as String?;
      final content = arguments['content'] as String?;

      if (path == null || content == null) {
        return ToolResult(
          content: [
            {
              'type': 'text',
              'text': 'Error: Se requieren los parámetros "path" y "content"',
            }
          ],
          isError: true,
        );
      }

      final file = File(path);
      file.writeAsStringSync(content);

      return ToolResult(
        content: [
          {
            'type': 'text',
            'text':
                'Archivo "$path" escrito exitosamente con ${content.length} caracteres',
          }
        ],
      );
    } catch (e) {
      return ToolResult(
        content: [
          {
            'type': 'text',
            'text': 'Error escribiendo archivo: $e',
          }
        ],
        isError: true,
      );
    }
  }

  ToolResult _handleCurrentTime(Map<String, dynamic> arguments) {
    final now = DateTime.now();
    final format = arguments['format'] as String? ?? 'iso';

    String timeString;
    switch (format) {
      case 'iso':
        timeString = now.toIso8601String();
        break;
      case 'local':
        timeString = now.toString();
        break;
      case 'unix':
        timeString = '${now.millisecondsSinceEpoch ~/ 1000}';
        break;
      default:
        timeString = now.toString();
    }

    return ToolResult(
      content: [
        {
          'type': 'text',
          'text': 'Hora actual ($format): $timeString',
        }
      ],
    );
  }

  ToolResult _handleGenerateRandom(Map<String, dynamic> arguments) {
    final min = arguments['min'] as int? ?? 0;
    final max = arguments['max'] as int? ?? 100;
    final count = arguments['count'] as int? ?? 1;

    if (min >= max) {
      return ToolResult(
        content: [
          {
            'type': 'text',
            'text': 'Error: "min" debe ser menor que "max"',
          }
        ],
        isError: true,
      );
    }

    final random = math.Random();
    final numbers = List.generate(
      count,
      (_) => random.nextInt(max - min + 1) + min,
    );

    return ToolResult(
      content: [
        {
          'type': 'text',
          'text': count == 1
              ? 'Número aleatorio: ${numbers.first}'
              : 'Números aleatorios: ${numbers.join(', ')}',
        }
      ],
    );
  }

  double _evaluateExpression(String expression) {
    // Calculadora muy simple - solo para demostración
    expression = expression.replaceAll(' ', '');

    // Buscar operadores en orden de precedencia
    final operators = ['+', '-', '*', '/'];

    for (final op in operators.reversed) {
      final parts = expression.split(op);
      if (parts.length == 2) {
        final left = double.parse(parts[0]);
        final right = double.parse(parts[1]);

        switch (op) {
          case '+':
            return left + right;
          case '-':
            return left - right;
          case '*':
            return left * right;
          case '/':
            if (right == 0) throw ArgumentError('División por cero');
            return left / right;
        }
      }
    }

    // Si no hay operadores, es solo un número
    return double.parse(expression);
  }
}

Future<void> main() async {
  final server = ExampleMCPServer();

  // Iniciar el servidor
  try {
    print('Iniciando servidor MCP en stdio...');
    await server.start();
  } catch (e) {
    print('Error: $e');
    exit(1);
  }
}
