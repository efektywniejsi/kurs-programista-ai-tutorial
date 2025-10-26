# Integracja GitHub z MCP

GitHub MCP to jedna z najpopularniejszych integracji. Pozwala Claude Code na bezpośrednie zarządzanie repozytoriami.

## Konfiguracja

### 1. Uzyskanie tokenu GitHub

1. Przejdź na https://github.com/settings/tokens
2. Kliknij "Generate new token" → "Generate new token (classic)"
3. Nadaj nazwę: `Claude Code MCP`
4. Wybierz uprawnienia:
   - ✅ `repo` (pełny dostęp do repozytoriów)
   - ✅ `read:org` (odczyt organizacji)
   - ✅ `workflow` (jeśli chcesz zarządzać GitHub Actions)
5. Kliknij "Generate token"
6. **Skopiuj token** (tylko raz go zobaczysz!)

### 2. Dodanie tokenu do .env

```bash
# .env
GITHUB_TOKEN=ghp_twój_token_tutaj
```

### 3. Konfiguracja w .mcp.json

Już jest skonfigurowana! Zobacz plik `.mcp.json`:

```json
"github": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-github"],
  "transport": "stdio",
  "description": "Integracja z GitHub",
  "scope": "project",
  "env": {
    "GITHUB_TOKEN": "${GITHUB_TOKEN}"
  }
}
```

---

## Możliwości

### Zarządzanie Issues

**Przykładowe zapytania:**
- "Pokaż mi wszystkie otwarte issues w tym repo"
- "Utwórz issue: Bug w module auth"
- "Zamknij issue #42"
- "Dodaj label 'bug' do issue #15"

**Co możesz zrobić:**
- 📋 Listowanie issues
- ➕ Tworzenie issues
- ✏️ Edycja issues
- 🏷️ Zarządzanie labelami
- 👤 Przypisywanie do użytkowników
- 🔒 Zamykanie/otwieranie issues

### Zarządzanie Pull Requestami

**Przykładowe zapytania:**
- "Pokaż otwarte PR-y"
- "Utwórz PR z brancha feature/new-auth do main"
- "Zmerguj PR #23"
- "Dodaj review do PR #15"

**Co możesz zrobić:**
- 📝 Listowanie PR-ów
- ➕ Tworzenie PR-ów
- 🔀 Mergowanie PR-ów
- 💬 Dodawanie komentarzy
- ✅ Aprobowanie zmian
- ❌ Requestowanie zmian

### Przeglądanie Kodu

**Przykładowe zapytania:**
- "Pokaż ostatnie commity w main"
- "Jaki jest content pliku src/auth.js?"
- "Pokaż zmiany w ostatnim PR"
- "Lista branchy w repo"

**Co możesz zrobić:**
- 📜 Przeglądanie commitów
- 📁 Czytanie plików
- 🌿 Listowanie branchy
- 🔍 Porównywanie zmian
- 📊 Historia projektu

### Zarządzanie Projektami

**Przykładowe zapytania:**
- "Pokaż projekty w organizacji"
- "Dodaj issue #42 do projektu 'Sprint Q4'"
- "Jaki jest status projektu?"

**Co możesz zrobić:**
- 📊 Listowanie projektów
- ➕ Dodawanie kart do projektów
- 📈 Tracking postępów
- 🗂️ Organizacja tasków

---

## Przykładowy Workflow

### Scenario: Fixing a Bug

1. **Znajdź issue:**
   ```
   "Pokaż issue z labelem 'bug'"
   ```

2. **Przeanalizuj kod:**
   ```
   "Pokaż plik src/components/Login.js"
   ```

3. **Napraw bug** (używając edycji Claude Code)

4. **Commit i Push** (używając git przez Claude)

5. **Utwórz PR:**
   ```
   "Utwórz PR z brancha fix/login-bug do main z tytułem 'Fix: Login validation bug'"
   ```

6. **Zamknij issue:**
   ```
   "Zamknij issue #42 jako fixed w PR #55"
   ```

---

## Best Practices

### Bezpieczeństwo

- 🔐 **Nigdy** nie commituj tokenu do repo
- 🔐 Używaj tokenów z minimalnymi uprawnieniami
- 🔐 Regularnie rotuj tokeny
- 🔐 Odwołuj tokeny które nie są używane

### Praca zespołowa

- 👥 Każdy członek zespołu używa swojego tokenu
- 👥 Token jest w `.env` (lokalnie)
- 👥 Konfiguracja serwera jest w `.mcp.json` (repo)
- 👥 Współdzielicie tę samą konfigurację

### Limity API

GitHub ma limity API:
- 5000 requestów/godzinę (autentykowany)
- 60 requestów/godzinę (nieautentykowany)

Claude Code zarządza requestami efektywnie, ale pamiętaj o limitach przy intensywnym użyciu.

---

## Rozwiązywanie problemów

### "Authentication failed"

✅ Sprawdź czy token jest w `.env`
✅ Sprawdź czy token ma wymagane uprawnienia
✅ Zrestartuj Claude Code po dodaniu tokenu

### "Rate limit exceeded"

✅ Poczekaj godzinę lub użyj innego tokenu
✅ GitHub resetuje limity co godzinę

### Serwer nie działa

```bash
# Test ręczny
npx -y @modelcontextprotocol/server-github --help

# Sprawdź czy token jest ustawiony
echo $GITHUB_TOKEN
```

---

## Zaawansowane

### GitHub Enterprise

Możesz używać z GitHub Enterprise:

```json
"github": {
  "env": {
    "GITHUB_TOKEN": "${GITHUB_TOKEN}",
    "GITHUB_API_URL": "https://github.your-company.com/api/v3"
  }
}
```

### Multiple Repositories

Jeden serwer GitHub MCP działa ze wszystkimi repo, do których masz dostęp!

Claude automatycznie wykrywa kontekst i używa odpowiedniego repo.

---

## Zadania do wykonania

1. ✅ Wygeneruj token GitHub
2. ✅ Dodaj token do `.env`
3. ✅ Zrestartuj Claude Code
4. 🧪 Wypróbuj: "Pokaż otwarte issues w tym repo"
5. 🧪 Wypróbuj: "Utwórz testowy issue"

🎉 Gratulacje! Masz działającą integrację GitHub!
