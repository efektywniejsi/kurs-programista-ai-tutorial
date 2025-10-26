# Jak używać weather-server

## Testowanie lokalnie (Stdio transport)

Możesz przetestować serwer ręcznie używając stdio:

```bash
# Uruchom serwer
node examples/weather-server.js

# W innym terminalu wyślij zapytanie (lub wpisz bezpośrednio):
echo '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{}}' | node examples/weather-server.js
```

## Dodanie do Claude Code

### Metoda 1: Ręczna konfiguracja

```bash
# Dodaj serwer używając CLI
claude mcp add --transport stdio weather-server -- node examples/weather-server.js
```

### Metoda 2: Przez plik .mcp.json (zalecane)

W następnych krokach tutoriala stworzymy plik `.mcp.json` który automatycznie skonfiguruje serwer.

## Przykładowe zapytania

Po dodaniu serwera do Claude Code, możesz zapytać:

- "Jaka jest pogoda w Warszawie?"
- "Sprawdź pogodę w Krakowie"
- "Porównaj pogodę w Gdańsku i Wrocławiu"

Claude automatycznie użyje narzędzia `get_weather` z naszego serwera MCP!

## Typy transportu

### Stdio (używany tutaj)
- Najlepszy dla lokalnych narzędzi
- Komunikacja przez stdin/stdout
- Prosty w implementacji

### HTTP
- Dla usług zdalnych
- RESTful API
- Skalowalne

### SSE (przestarzałe)
- Server-Sent Events
- Nie zalecane dla nowych projektów
