# Inne popularne integracje MCP

Poza GitHub i bazami danych, istnieje wiele innych użytecznych integracji MCP.

## Dostępne oficjalne serwery

### Filesystem (Lokalny system plików)

Dostęp do plików poza projektem.

```json
"filesystem": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-filesystem", "/path/to/directory"],
  "transport": "stdio",
  "description": "Access to filesystem",
  "scope": "local"
}
```

**Możliwości:**
- Czytanie plików
- Zapisywanie plików
- Listowanie katalogów
- Wyszukiwanie plików

**Przykłady użycia:**
- "Pokaż zawartość katalogu ~/Documents"
- "Znajdź wszystkie pliki .pdf w ~/Downloads"

---

### Puppeteer (Browser Automation)

Automatyzacja przeglądarki.

```json
"puppeteer": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-puppeteer"],
  "transport": "stdio",
  "description": "Browser automation",
  "scope": "local"
}
```

**Możliwości:**
- Otwieranie stron web
- Wykonywanie akcji (kliknięcia, scroll)
- Robienie screenshotów
- Ekstrakcja danych

**Przykłady użycia:**
- "Zrób screenshot strony example.com"
- "Wypełnij formularz na tej stronie"
- "Pobierz wszystkie linki ze strony"

---

### Brave Search (Wyszukiwarka)

Wyszukiwanie w internecie.

```json
"brave-search": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-brave-search"],
  "transport": "stdio",
  "description": "Web search via Brave",
  "scope": "user",
  "env": {
    "BRAVE_API_KEY": "${BRAVE_API_KEY}"
  }
}
```

**Wymagane:** API key z https://brave.com/search/api/

**Możliwości:**
- Wyszukiwanie w internecie
- Aktualnych informacji
- News i artykuły

---

### Slack (Komunikacja)

Integracja ze Slackiem.

```json
"slack": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-slack"],
  "transport": "stdio",
  "description": "Slack integration",
  "scope": "project",
  "env": {
    "SLACK_BOT_TOKEN": "${SLACK_BOT_TOKEN}",
    "SLACK_TEAM_ID": "${SLACK_TEAM_ID}"
  }
}
```

**Możliwości:**
- Wysyłanie wiadomości
- Czytanie kanałów
- Zarządzanie thread'ami
- Przeszukiwanie historii

**Przykłady użycia:**
- "Wyślij wiadomość na #general: Deploy completed"
- "Pokaż ostatnie wiadomości z #dev-team"

---

### Google Drive

Dostęp do plików w Google Drive.

```json
"gdrive": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-gdrive"],
  "transport": "stdio",
  "description": "Google Drive access",
  "scope": "user",
  "env": {
    "GOOGLE_CLIENT_ID": "${GOOGLE_CLIENT_ID}",
    "GOOGLE_CLIENT_SECRET": "${GOOGLE_CLIENT_SECRET}"
  }
}
```

**Możliwości:**
- Listowanie plików
- Czytanie dokumentów
- Upload plików
- Udostępnianie

---

### Memory (Persystentna pamięć)

Zapamiętywanie informacji między sesjami.

```json
"memory": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-memory"],
  "transport": "stdio",
  "description": "Persistent memory across sessions",
  "scope": "user"
}
```

**Możliwości:**
- Zapamiętywanie faktów
- Preferencje użytkownika
- Kontekst projektów
- Knowledge base

**Przykłady użycia:**
- "Zapamiętaj że preferuję TypeScript"
- "Jaki jest mój preferowany stack technologiczny?"

---

## Community Servers

### Sentry (Error Monitoring)

Monitoring błędów aplikacji.

**Setup:** Wymaga hostowania własnego serwera MCP lub użycia community version.

**Możliwości:**
- Przeglądanie błędów
- Analiza stack traces
- Performance monitoring
- Issue tracking

---

### Jira (Project Management)

Zarządzanie projektami w Jira.

**Setup:** Community-maintained server.

**Możliwości:**
- Zarządzanie taskami
- Sprint planning
- Reports
- Workflows

---

### Figma (Design)

Dostęp do projektów Figma.

**Setup:** Community-maintained server.

**Możliwości:**
- Pobieranie design specs
- Export assets
- Komponenty
- Style guide

---

## Tworzenie własnego serwera MCP

### Kiedy stworzyć własny serwer?

- 🔧 Integracja z internal toolem
- 🔧 Custom API firmy
- 🔧 Specjalistyczne narzędzie
- 🔧 Brak istniejącego serwera

### Podstawowa struktura

```javascript
// my-custom-server.js
#!/usr/bin/env node

const TOOLS = [
  {
    name: "my_tool",
    description: "Opis narzędzia",
    inputSchema: {
      type: "object",
      properties: {
        param: { type: "string", description: "Parametr" }
      },
      required: ["param"]
    }
  }
];

function handleRequest(request) {
  const { method, params } = request;

  switch (method) {
    case "initialize":
      return {
        jsonrpc: "2.0",
        id: request.id,
        result: {
          protocolVersion: "0.1.0",
          serverInfo: { name: "my-server", version: "1.0.0" },
          capabilities: { tools: {} }
        }
      };

    case "tools/list":
      return {
        jsonrpc: "2.0",
        id: request.id,
        result: { tools: TOOLS }
      };

    case "tools/call":
      // Twoja logika...
      return {
        jsonrpc: "2.0",
        id: request.id,
        result: {
          content: [{ type: "text", text: "Result" }]
        }
      };
  }
}

// Stdio transport
process.stdin.on('data', (chunk) => {
  const request = JSON.parse(chunk.toString());
  const response = handleRequest(request);
  process.stdout.write(JSON.stringify(response) + '\n');
});
```

### Dodanie do .mcp.json

```json
"my-custom-server": {
  "command": "node",
  "args": ["./my-custom-server.js"],
  "transport": "stdio",
  "description": "My custom MCP server"
}
```

---

## Kompletna konfiguracja .mcp.json

Przykład z wieloma serwerami:

```json
{
  "mcpServers": {
    "weather-server": {
      "command": "node",
      "args": ["examples/weather-server.js"],
      "transport": "stdio",
      "scope": "local"
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "transport": "stdio",
      "scope": "project",
      "env": { "GITHUB_TOKEN": "${GITHUB_TOKEN}" }
    },
    "sqlite": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sqlite", "./data/example.db"],
      "transport": "stdio",
      "scope": "project"
    },
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/Users/me/Documents"],
      "transport": "stdio",
      "scope": "user"
    },
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"],
      "transport": "stdio",
      "scope": "user"
    }
  }
}
```

---

## Best Practices

### Wybór serwerów

- ✅ Zacznij od podstawowych (GitHub, SQLite)
- ✅ Dodawaj w miarę potrzeb
- ✅ Nie instaluj wszystkich naraz
- ✅ Testuj każdy serwer osobno

### Organizacja

- 📁 Local scope - eksperymenty
- 📁 Project scope - serwery zespołowe
- 📁 User scope - osobiste narzędzia

### Performance

- ⚡ Więcej serwerów = wolniejszy start
- ⚡ Usuń nieużywane serwery
- ⚡ Używaj lazy loading gdzie możliwe

---

## Zasoby

### Oficjalne

- [MCP Documentation](https://docs.claude.com/en/docs/claude-code/mcp)
- [MCP Specification](https://spec.modelcontextprotocol.io/)
- [Official Servers](https://github.com/modelcontextprotocol)

### Community

- [Awesome MCP](https://github.com/punkpeye/awesome-mcp)
- [MCP Servers Registry](https://github.com/modelcontextprotocol/servers)
- [Community Discord](https://discord.gg/anthropic)

### Tworzenie serwerów

- [MCP SDK TypeScript](https://github.com/modelcontextprotocol/typescript-sdk)
- [MCP SDK Python](https://github.com/modelcontextprotocol/python-sdk)
- [Server Template](https://github.com/modelcontextprotocol/server-template)

---

## 🎉 Gratulacje!

Ukończyłeś tutorial MCP! Teraz wiesz:

- ✅ Czym jest Model Context Protocol
- ✅ Jak konfigurować serwery MCP
- ✅ Jak używać popularnych integracji
- ✅ Jak tworzyć własne serwery
- ✅ Best practices i bezpieczeństwo

### Następne kroki

1. 🚀 Wypróbuj różne serwery z projektem
2. 🔨 Stwórz własny serwer MCP
3. 🤝 Podziel się swoją konfiguracją z zespołem
4. 📚 Zgłęb dokumentację MCP
5. 💡 Zautomatyzuj swój workflow!

### Feedback

Masz pomysł na ulepszenie tutoriala? Zgłoś issue lub PR na GitHub!

---

**Happy coding with MCP! 🚀**
