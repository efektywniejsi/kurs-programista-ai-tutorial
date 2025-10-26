# Wyjaśnienie konfiguracji .mcp.json

Plik `.mcp.json` automatycznie konfiguruje serwery MCP dla projektu.

## Podstawowa struktura

```json
{
  "mcpServers": {
    "nazwa-serwera": {
      "command": "komenda",
      "args": ["argumenty"],
      "transport": "typ-transportu",
      "description": "opis",
      "scope": "zakres"
    }
  }
}
```

## Pola konfiguracji

### command (wymagane)
Komenda do uruchomienia serwera.

Przykłady:
- `"node"` - dla skryptów Node.js
- `"python"` - dla skryptów Python
- `"npx"` - dla pakietów npm

### args (wymagane)
Tablica argumentów dla komendy.

Przykłady:
- `["examples/weather-server.js"]`
- `["-y", "@modelcontextprotocol/server-github"]`
- `["script.py", "--config", "config.json"]`

### transport (wymagane)
Typ transportu komunikacji:
- `"stdio"` - standard input/output (domyślne, zalecane dla lokalnych)
- `"http"` - HTTP REST API
- `"sse"` - Server-Sent Events (przestarzałe)

### description (opcjonalne)
Opis serwera dla dokumentacji.

### scope (opcjonalne)
Zakres konfiguracji:
- `"local"` - tylko lokalnie, nie commitowane
- `"project"` - dla całego projektu (domyślne)
- `"user"` - dla wszystkich projektów użytkownika

## Nasza konfiguracja

Obecnie mamy skonfigurowany `weather-server`:

```json
{
  "mcpServers": {
    "weather-server": {
      "command": "node",
      "args": ["examples/weather-server.js"],
      "transport": "stdio",
      "description": "Prosty przykładowy serwer MCP - pogoda",
      "scope": "local"
    }
  }
}
```

Ta konfiguracja:
- ✅ Uruchamia nasz serwer pogody
- ✅ Używa transportu stdio (idealny dla lokalnych narzędzi)
- ✅ Jest lokalna (nie będzie commitowana do repo)

## Automatyczne ładowanie

Claude Code automatycznie wykrywa i ładuje `.mcp.json` przy starcie projektu!

**Nie musisz ręcznie dodawać serwera przez CLI** - wystarczy plik `.mcp.json`.

## Następne kroki

W kolejnych krokach dodamy:
- Więcej serwerów do konfiguracji
- Przykłady różnych zakresów (scope)
- Zmienne środowiskowe dla tokenów API
