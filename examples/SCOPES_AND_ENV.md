# Zakresy konfiguracji i zmienne środowiskowe

## Zakresy (Scopes)

### Local Scope
```json
"scope": "local"
```

**Kiedy używać:**
- Eksperymenty i testowanie
- Narzędzia specyficzne dla Twojego środowiska
- Konfiguracje z wrażliwymi danymi (API keys)

**Charakterystyka:**
- ❌ NIE jest commitowane do repo
- ✅ Tylko Ty widzisz ten serwer
- ✅ Idealny dla development

**Przykład:** Nasz `weather-server`

### Project Scope (Domyślne)
```json
"scope": "project"
```

**Kiedy używać:**
- Narzędzia używane przez cały zespół
- Standardowe integracje projektu
- Współdzielona konfiguracja

**Charakterystyka:**
- ✅ Commitowane do repo (plik `.mcp.json`)
- ✅ Cały zespół ma te same serwery
- ✅ Synchronizacja przez Git

**Przykład:** Serwer `github` dla zarządzania repo

### User Scope
```json
"scope": "user"
```

**Kiedy używać:**
- Narzędzia używane we wszystkich projektach
- Osobiste preferencje
- Konfiguracja na poziomie systemu

**Charakterystyka:**
- 🏠 Przechowywane w katalogu domowym
- ✅ Dostępne we wszystkich projektach
- ❌ NIE synchronizowane z zespołem

**Przykład:** Osobiste integracje (np. Notion, calendar)

---

## Zmienne środowiskowe

### Podstawowe użycie

W pliku `.mcp.json` możesz używać zmiennych środowiskowych:

```json
{
  "env": {
    "GITHUB_TOKEN": "${GITHUB_TOKEN}",
    "API_KEY": "${MY_API_KEY}"
  }
}
```

### Ustawianie zmiennych

#### Metoda 1: .env (zalecane dla local scope)

Stwórz plik `.env` w głównym katalogu projektu:

```bash
GITHUB_TOKEN=ghp_xxxxxxxxxxxxx
MY_API_KEY=sk_test_xxxxxxxxxxxxx
```

**⚠️ WAŻNE:** Dodaj `.env` do `.gitignore`!

#### Metoda 2: Środowisko systemowe

```bash
# macOS/Linux
export GITHUB_TOKEN=ghp_xxxxxxxxxxxxx

# Windows (PowerShell)
$env:GITHUB_TOKEN="ghp_xxxxxxxxxxxxx"

# Windows (CMD)
set GITHUB_TOKEN=ghp_xxxxxxxxxxxxx
```

#### Metoda 3: Konfiguracja w profilu

Dodaj do `~/.bashrc`, `~/.zshrc` lub `~/.profile`:

```bash
export GITHUB_TOKEN=ghp_xxxxxxxxxxxxx
export MY_API_KEY=sk_test_xxxxxxxxxxxxx
```

---

## Przykłady z naszej konfiguracji

### 1. Weather Server (Local)
```json
"weather-server": {
  "scope": "local"
}
```
- Tylko dla Ciebie
- Nie wymaga tokenów
- Świetny do nauki

### 2. GitHub Server (Project)
```json
"github": {
  "scope": "project",
  "env": {
    "GITHUB_TOKEN": "${GITHUB_TOKEN}"
  }
}
```
- Współdzielony z zespołem
- Wymaga tokenu GitHub (https://github.com/settings/tokens)
- Każdy członek zespołu ustawia swój token lokalnie

### 3. SQLite Server (Project)
```json
"sqlite": {
  "scope": "project"
}
```
- Współdzielony z zespołem
- Baza danych w projekcie (`./data/example.db`)
- Nie wymaga dodatkowej konfiguracji

---

## Best Practices

### Bezpieczeństwo
- ⚠️ **NIGDY** nie commituj tokenów do repo
- ✅ Używaj zmiennych środowiskowych
- ✅ Dodaj `.env` do `.gitignore`
- ✅ Używaj `local` scope dla wrażliwych konfiguracji

### Organizacja
- 📁 `local` - Twoje eksperymenty
- 📁 `project` - Narzędzia zespołu
- 📁 `user` - Twoje globalne narzędzia

### Dokumentacja
- 📝 Dokumentuj wymagane zmienne w README
- 📝 Podaj instrukcje dla zespołu
- 📝 Udostępnij przykładowy `.env.example`

---

## Zadanie do wykonania

1. Stwórz plik `.env` z twoim tokenem GitHub
2. Sprawdź czy serwer `github` działa
3. Wypróbuj zapytać Claude: "Pokaż otwarte issues w tym repo"

🎯 Gratulacje! Teraz rozumiesz zakresy i zmienne środowiskowe w MCP!
