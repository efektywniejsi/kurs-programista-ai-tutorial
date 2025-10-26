# Tutorial MCP - Model Context Protocol

Witaj w interaktywnym tutorialu o **Model Context Protocol (MCP)**!

MCP to otwarty standard pozwalający Claude Code na integrację z zewnętrznymi narzędziami i usługami.

---

## 1.

### 1.1

Model Context Protocol (MCP) to otwartoźródłowy protokół umożliwiający integrację AI z różnymi narzędziami i usługami.

**Główne zalety:**
- Standaryzowana komunikacja między AI a narzędziami
- Dostęp do baz danych, API i usług zewnętrznych
- Możliwość rozszerzania możliwości Claude Code

**Przykładowe zastosowania:**
- Zarządzanie issue trackerami (GitHub, Jira)
- Analiza danych monitoringowych (Sentry)
- Dostęp do baz danych
- Integracja z narzędziami projektowymi (Figma)
- Automatyzacja komunikacji (Email, Slack)

#### HINTS

- MCP działa jako most między Claude a zewnętrznymi systemami
- Protokół jest otwartoźródłowy i rozwijany przez Anthropic
- Możesz tworzyć własne serwery MCP

### 1.2

MCP opiera się na architekturze klient-serwer:

**Komponenty:**
1. **Klient MCP** - Claude Code
2. **Serwer MCP** - Aplikacja udostępniająca funkcjonalność
3. **Transport** - Warstwa komunikacji (HTTP, SSE, Stdio)

**Schemat działania:**
```
Claude Code → Transport → Serwer MCP → Usługa zewnętrzna
              ←         ←              ←
```

#### HINTS

- Transport określa sposób komunikacji
- Serwery MCP mogą być lokalne lub zdalne
- Jeden serwer może udostępniać wiele funkcji

### 1.3

MCP wspiera trzy metody komunikacji:

**1. HTTP (Zalecane dla usług zdalnych)**
```bash
claude mcp add --transport http <nazwa> <url>
```

**2. Stdio (Dla procesów lokalnych)**
```bash
claude mcp add --transport stdio <nazwa> -- <komenda>
```

**3. SSE (Przestarzałe)**
```bash
claude mcp add --transport sse <nazwa> <url>
```

#### HINTS

- HTTP najlepsze dla API zewnętrznych
- Stdio idealne dla narzędzi lokalnych
- SSE jest wycofywane, unikaj w nowych projektach

---

## 2.

### 2.1

Aby dodać serwer MCP, użyj komendy `claude mcp add`:

**Podstawowa składnia:**
```bash
claude mcp add --transport <typ> <nazwa> <parametry>
```

**Przykład - GitHub:**
```bash
claude mcp add --transport stdio github -- npx -y @modelcontextprotocol/server-github
```

**Przykład - Sentry (HTTP):**
```bash
claude mcp add --transport http sentry https://sentry-mcp.example.com
```

#### HINTS

- Nazwa serwera musi być unikalna
- Możesz dodać wiele serwerów jednocześnie
- Sprawdź dostępne serwery na stronie Anthropic

### 2.2

MCP oferuje trzy poziomy konfiguracji:

**1. Local (Lokalny)**
- Tylko dla aktualnego projektu
- Nie jest współdzielony z zespołem

**2. Project (Projektowy)**
- Zapisany w `.mcp.json`
- Współdzielony przez Git
- Dostępny dla całego zespołu

**3. User (Użytkownika)**
- Dostępny we wszystkich projektach
- Konfiguracja osobista
- Przechowywana w katalogu domowym

**Wybór zakresu:**
```bash
claude mcp add --scope project --transport stdio github -- npx -y @modelcontextprotocol/server-github
```

#### HINTS

- Project scope najlepszy dla projektów zespołowych
- User scope dla narzędzi używanych w wielu projektach
- Local scope dla eksperymentów

### 2.3

**Lista serwerów:**
```bash
claude mcp list
```

**Usuwanie serwera:**
```bash
claude mcp remove <nazwa>
```

**Aktualizacja serwera:**
```bash
claude mcp update <nazwa>
```

**Testowanie połączenia:**
```bash
claude mcp test <nazwa>
```

#### HINTS

- Regularnie aktualizuj serwery MCP
- Usuń niewykorzystywane serwery
- Testuj połączenia po dodaniu nowego serwera

---

## 3.

### 3.1

GitHub MCP umożliwia zarządzanie repozytoriami bezpośrednio z Claude Code.

**Instalacja:**
```bash
claude mcp add --transport stdio github -- npx -y @modelcontextprotocol/server-github
```

**Możliwości:**
- Tworzenie i zarządzanie issue
- Obsługa Pull Requestów
- Przeglądanie commitów
- Zarządzanie projektami

**Przykładowe użycie:**
Po instalacji możesz prosić Claude:
- "Pokaż mi otwarte issue w tym projekcie"
- "Utwórz nowy PR z moich zmian"
- "Sprawdź ostatnie commity"

#### HINTS

- Wymaga tokenu GitHub (GITHUB_TOKEN)
- Respektuje uprawnienia tokenu
- Działa z GitHub Enterprise

### 3.2

MCP pozwala na bezpośredni dostęp do baz danych.

**Przykład - PostgreSQL:**
```bash
claude mcp add --transport stdio postgres -- npx -y @modelcontextprotocol/server-postgres postgresql://user:pass@localhost:5432/db
```

**Przykład - SQLite:**
```bash
claude mcp add --transport stdio sqlite -- npx -y @modelcontextprotocol/server-sqlite /path/to/database.db
```

**Możliwości:**
- Wykonywanie zapytań SQL
- Analiza struktury bazy
- Eksport danych
- Migracje schematów

#### HINTS

- Zachowaj ostrożność z uprawnieniami zapisu
- Używaj połączeń tylko do odczytu dla bezpieczeństwa
- Testuj zapytania przed wykonaniem

### 3.3

**Sentry (Monitoring)**
```bash
claude mcp add --transport http sentry <sentry-mcp-url>
```
Możliwości: Analiza błędów, monitorowanie wydajności

**Figma (Design)**
```bash
claude mcp add --transport http figma <figma-mcp-url>
```
Możliwości: Dostęp do projektów, eksport zasobów

**Notion (Dokumentacja)**
```bash
claude mcp add --transport stdio notion -- npx -y @modelcontextprotocol/server-notion
```
Możliwości: Zarządzanie stronami, bazy danych

**Stripe (Płatności)**
```bash
claude mcp add --transport stdio stripe -- npx -y @modelcontextprotocol/server-stripe
```
Możliwości: Zarządzanie klientami, płatnościami, subskrypcjami

#### HINTS

- Każda integracja wymaga własnej konfiguracji
- Sprawdź dokumentację konkretnego serwera MCP
- Niektóre serwery wymagają kluczy API

---

#### Gratulacje!

Ukończyłeś tutorial MCP! Teraz wiesz:

- Czym jest Model Context Protocol
- Jak instalować i konfigurować serwery MCP
- Jakie są popularne integracje
- Jak zarządzać serwerami MCP

**Następne kroki:**
1. Eksperymentuj z różnymi serwerami MCP
2. Stwórz własny serwer MCP
3. Zintegruj MCP z Twoim workflow

**Przydatne linki:**
- [Dokumentacja Claude Code MCP](https://docs.claude.com/en/docs/claude-code/mcp)
- [Specyfikacja MCP](https://spec.modelcontextprotocol.io/)
- [Lista dostępnych serwerów](https://github.com/modelcontextprotocol)

Powodzenia w pracy z MCP!
