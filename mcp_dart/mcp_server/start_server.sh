#!/bin/bash

# Script de inicio para el servidor MCP
# Uso: ./start_server.sh [puerto]

PORT=${1:-8080}
SERVER_DIR="/Users/jcampuza/Documents/GitHub/mcp_dart/mcp_server"

echo "🚀 Iniciando servidor MCP Dart..."
echo "📁 Directorio: $SERVER_DIR"
echo "🔌 Puerto: $PORT"

cd "$SERVER_DIR"

# Verificar que Dart esté instalado
if ! command -v dart &> /dev/null; then
    echo "❌ Error: Dart no está instalado"
    exit 1
fi

# Instalar dependencias si es necesario
if [ ! -d ".dart_tool" ]; then
    echo "📦 Instalando dependencias..."
    dart pub get
fi

# Ejecutar tests para verificar
echo "🧪 Ejecutando tests..."
if dart test > /dev/null 2>&1; then
    echo "✅ Tests pasaron"
else
    echo "⚠️  Advertencia: Algunos tests fallaron"
fi

# Iniciar servidor
echo "▶️  Iniciando servidor..."
exec dart run

echo "🛑 Servidor detenido"
