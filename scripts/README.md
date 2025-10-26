# Skrypty zarządzania MCP

Ten katalog zawiera pomocnicze skrypty do zarządzania serwerami MCP.

## Dostępne skrypty

### setup.sh - Początkowa konfiguracja

Automatyzuje setup projektu:
- Sprawdza zależności (Node.js)
- Tworzy plik .env z template
- Tworzy katalog data/
- Testuje serwer weather-server

**Użycie:**
```bash
bash scripts/setup.sh
```

**Kiedy używać:**
- Przy pierwszym uruchomieniu projektu
- Po sklonowaniu repo
- Aby zresetować konfigurację

---

### test-server.sh - Testowanie serwerów

Testuje serwery MCP lokalnie bez Claude Code.

**Użycie:**
```bash
# Test weather-server
bash scripts/test-server.sh weather-server

# Lub po prostu
bash scripts/test-server.sh
```

**Co testuje:**
- `initialize` - inicjalizacja serwera
- `tools/list` - lista dostępnych narzędzi
- `tools/call` - wywołanie narzędzia z przykładowymi danymi

**Kiedy używać:**
- Podczas developmentu nowego serwera
- Debugowanie problemów z serwerem
- Weryfikacja, że serwer działa przed dodaniem do Claude Code

---

## Dodawanie własnych skryptów

### Template dla nowego skryptu

```bash
#!/bin/bash

# Opis skryptu

echo "🚀 Nazwa skryptu"

# Twoja logika...

echo "✅ Zakończono!"
```

### Nadawanie uprawnień wykonywania

```bash
chmod +x scripts/your-script.sh
```

---

## Integracja z package.json

Możesz dodać skrypty do `package.json`:

```json
{
  "scripts": {
    "setup": "bash scripts/setup.sh",
    "test:server": "bash scripts/test-server.sh",
    "mcp:list": "claude mcp list",
    "mcp:test": "claude mcp test"
  }
}
```

Wtedy możesz używać:

```bash
npm run setup
npm run test:server
npm run mcp:list
```

---

## Tips & Tricks

### Szybkie testowanie JSON-RPC

```bash
# Testuj bezpośrednio przez stdin
echo '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{}}' | node examples/weather-server.js
```

### Debug mode

Dodaj do skryptu:

```bash
set -x  # Włącz verbose mode
set -e  # Exit on error
```

### Kolorowe outputy

```bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}✅ Success${NC}"
echo -e "${RED}❌ Error${NC}"
```

---

## Rozwiązywanie problemów

### "Permission denied"

```bash
chmod +x scripts/*.sh
```

### "node: command not found"

Zainstaluj Node.js lub sprawdź PATH:

```bash
export PATH="/usr/local/bin:$PATH"
```

### "Bad interpreter"

Skrypt ma złe znaki końca linii (Windows vs Unix):

```bash
dos2unix scripts/*.sh
```

---

## Dalsze materiały

- [Dokumentacja MCP CLI](https://docs.claude.com/en/docs/claude-code/mcp)
- [JSON-RPC 2.0 Specification](https://www.jsonrpc.org/specification)
- [Bash Scripting Guide](https://www.gnu.org/software/bash/manual/)
