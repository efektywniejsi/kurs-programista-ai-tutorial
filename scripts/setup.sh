#!/bin/bash

# Skrypt do szybkiego setupu projektu MCP

echo "🚀 Setup projektu MCP Tutorial"
echo ""

# Sprawdź czy Node.js jest zainstalowany
if ! command -v node &> /dev/null; then
    echo "❌ Node.js nie jest zainstalowany!"
    echo "Zainstaluj Node.js z https://nodejs.org/"
    exit 1
fi

echo "✅ Node.js: $(node --version)"
echo ""

# Sprawdź czy plik .env istnieje
if [ ! -f .env ]; then
    echo "📝 Tworzenie pliku .env z template..."
    cp .env.example .env
    echo "⚠️  WAŻNE: Wypełnij plik .env swoimi tokenami!"
    echo "   Edytuj plik: nano .env lub code .env"
    echo ""
else
    echo "✅ Plik .env już istnieje"
    echo ""
fi

# Sprawdź czy istnieje katalog data
if [ ! -d data ]; then
    echo "📁 Tworzenie katalogu data/..."
    mkdir -p data
    echo "✅ Katalog data/ utworzony"
    echo ""
fi

# Test weather-server
echo "🧪 Testowanie weather-server..."
if bash scripts/test-server.sh weather-server > /dev/null 2>&1; then
    echo "✅ Weather server działa poprawnie!"
else
    echo "⚠️  Weather server może mieć problemy"
fi
echo ""

# Podsumowanie
echo "🎉 Setup zakończony!"
echo ""
echo "Następne kroki:"
echo "1. Wypełnij plik .env tokenami (jeśli potrzebujesz GitHub/innych integracji)"
echo "2. Otwórz projekt w Claude Code"
echo "3. Serwery MCP zostaną automatycznie załadowane z .mcp.json"
echo "4. Wypróbuj: 'Jaka jest pogoda w Warszawie?'"
echo ""
echo "📚 Więcej informacji: cat examples/HOW_TO_USE.md"
