#!/bin/bash

# Script para conectarte manualmente al servidor MCP

echo "🚀 Iniciando servidor MCP..."
cd /Users/jcampuza/Documents/GitHub/mcp_dart/mcp_server

# Método 1: Ejecución directa
echo "Método 1: Servidor directo"
dart run &
SERVER_PID=$!

sleep 2

echo -e "\n📤 Enviando solicitudes de prueba..."

# Ejemplo de solicitud JSON-RPC
echo '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2024-11-05","capabilities":{"tools":{}},"clientInfo":{"name":"Manual Client","version":"1.0.0"}}}' | nc localhost 8080

echo -e "\n🛑 Deteniendo servidor..."
kill $SERVER_PID

echo "✅ Listo!"
