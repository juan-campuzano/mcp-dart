# MCP Dart Server

Un servidor completo de Model Context Protocol (MCP) implementado en Dart puro.

## Características

### 🛠️ Herramientas Disponibles

1. **calculate** - Evaluador de expresiones matemáticas
2. **list_files** - Lista archivos en un directorio
3. **read_file** - Lee contenido de archivos
4. **write_file** - Escribe contenido a archivos
5. **current_time** - Obtiene la fecha y hora actual
6. **generate_random** - Genera números aleatorios

### 📦 Recursos

- **Server Information** (`info://server`) - Información del servidor

## Instalación

```bash
cd mcp_server
dart pub get
```

## Uso

### Ejecutar el servidor

```bash
dart run bin/mcp_dart_server.dart
```

### Integración con MCP Clients

El servidor implementa el protocolo MCP 2024-11-05 y es compatible con:

- **Claude Desktop** con Model Context Protocol
- **Cline** (VS Code Extension)
- **Otros clientes MCP**

### Configuración para Claude Desktop

Agregar a `claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "dart-server": {
      "command": "dart",
      "args": ["run", "/ruta/a/mcp_dart/mcp_server/bin/mcp_dart_server.dart"]
    }
  }
}
```

### Configuración para Cline

En VS Code con Cline:

1. Abrir Command Palette (Cmd+Shift+P)
2. Buscar "Cline: Open MCP Settings"
3. Agregar servidor:

```json
{
  "dart-server": {
    "command": "dart",
    "args": ["run", "/ruta/a/mcp_dart/mcp_server/bin/mcp_dart_server.dart"]
  }
}
```

## Ejemplos de Uso

### Cálculos Matemáticos

```json
{
  "method": "tools/call",
  "params": {
    "name": "calculate",
    "arguments": {
      "expression": "2 + 2 * 3"
    }
  }
}
```

### Gestión de Archivos

```json
{
  "method": "tools/call",
  "params": {
    "name": "write_file",
    "arguments": {
      "path": "test.txt",
      "content": "¡Hola desde MCP!"
    }
  }
}
```

## Personalización

### Agregar Nuevas Herramientas

En `mcp_dart_server.dart`, agregar herramientas en el constructor:

```dart
class MiServidor extends ExampleMCPServer {
  MiServidor() : super() {
    // Registrar nueva herramienta
    registerTool(MCPTool(
      name: 'mi_herramienta',
      description: 'Descripción de mi herramienta',
      inputSchema: {
        'type': 'object',
        'properties': {
          'param': {'type': 'string', 'description': 'Parámetro'}
        },
        'required': ['param']
      }
    ));
  }
  
  @override
  Future<Map<String, dynamic>> callTool(String name, Map<String, dynamic> arguments) async {
    if (name == 'mi_herramienta') {
      return {'result': 'Mi resultado: ${arguments['param']}'};
    }
    return super.callTool(name, arguments);
  }
}
```

## Arquitectura

- **mcp_protocol.dart** - Clases del protocolo MCP
- **mcp_server.dart** - Servidor base abstracto y implementación stdio
- **mcp_dart_server.dart** - Servidor de ejemplo con herramientas

## Protocolo

Implementa MCP versión 2024-11-05 con soporte para:

- ✅ Inicialización de servidor
- ✅ Listado de herramientas
- ✅ Llamadas a herramientas
- ✅ Listado de recursos
- ✅ Lectura de recursos
- ✅ Manejo de errores
- ✅ Comunicación stdio

## Contribuir

1. Fork el proyecto
2. Crear branch para tu feature
3. Agregar tus herramientas personalizadas
4. Enviar Pull Request

## Licencia

MIT License
