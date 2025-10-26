#!/bin/bash

# Skrypt do testowania serwera MCP lokalnie

echo "🧪 Testowanie serwera MCP..."
echo ""

SERVER_NAME=${1:-weather-server}

case $SERVER_NAME in
  weather-server)
    echo "📍 Testowanie weather-server..."
    echo '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{}}' | node examples/weather-server.js
    echo ""
    echo "✅ Test initialize zakończony"
    echo ""
    echo "📍 Testowanie tools/list..."
    echo '{"jsonrpc":"2.0","id":2,"method":"tools/list","params":{}}' | node examples/weather-server.js
    echo ""
    echo "✅ Test tools/list zakończony"
    echo ""
    echo "📍 Testowanie tools/call..."
    echo '{"jsonrpc":"2.0","id":3,"method":"tools/call","params":{"name":"get_weather","arguments":{"city":"Warszawa"}}}' | node examples/weather-server.js
    echo ""
    echo "✅ Test tools/call zakończony"
    ;;
  *)
    echo "❌ Nieznany serwer: $SERVER_NAME"
    echo "Dostępne serwery: weather-server"
    exit 1
    ;;
esac

echo ""
echo "🎉 Wszystkie testy zakończone!"
