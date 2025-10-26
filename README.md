# Tutorial MCP dla CodeRoad

Interaktywny tutorial o **Model Context Protocol (MCP)** przygotowany dla rozszerzenia CodeRoad w VS Code.

**🎯 Unikalność:** Ten tutorial automatycznie wdraża kod w każdym kroku! CodeRoad stopniowo buduje przykładowy projekt MCP, pokazując jak łatwo można integrować MCP w swoich projektach.

## Czego się nauczysz?

- ✅ Podstawy Model Context Protocol
- ✅ Tworzenie własnego serwera MCP (weather-server)
- ✅ Konfiguracja przez .mcp.json
- ✅ Zakresy (local, project, user) i zmienne środowiskowe
- ✅ Integracje z GitHub, SQLite, i innymi usługami
- ✅ Skrypty automatyzacji i zarządzania
- ✅ Best practices i bezpieczeństwo

## Jak uruchomić tutorial?

### Wymagania

1. VS Code
2. Rozszerzenie CodeRoad
3. Node.js (v14 lub nowszy)

### Instrukcja

1. Otwórz VS Code
2. Zainstaluj rozszerzenie CodeRoad z Marketplace
3. Otwórz paletę poleceń (Cmd/Ctrl + Shift + P)
4. Wpisz "CodeRoad: Start"
5. Wybierz ten tutorial lub wklej URL do `tutorial.json`

## Struktura tutoriala

Tutorial składa się z 3 głównych lekcji:

### 1. Wprowadzenie do MCP
- **Krok 1.1:** Podstawowa struktura projektu
- **Krok 1.2:** Implementacja prostego serwera MCP (weather-server.js)
- **Krok 1.3:** Dokumentacja transportu i użycia

### 2. Instalacja i konfiguracja
- **Krok 2.1:** Tworzenie pliku .mcp.json z konfiguracją
- **Krok 2.2:** Zakresy (scopes) i zmienne środowiskowe
- **Krok 2.3:** Skrypty zarządzania i testowania

### 3. Popularne integracje
- **Krok 3.1:** Integracja z GitHub (issues, PR, repo management)
- **Krok 3.2:** Integracja z bazami danych (SQLite, PostgreSQL)
- **Krok 3.3:** Inne integracje i tworzenie własnych serwerów

## Przykładowy kod

Tutorial automatycznie wdraża kod w każdym kroku, budując kompletny projekt:

```
mcp-tutorial/
├── examples/
│   ├── weather-server.js        # Prosty serwer MCP (Krok 1.2)
│   ├── CONFIG_EXPLAINED.md      # Dokumentacja konfiguracji
│   ├── SCOPES_AND_ENV.md        # Zakresy i zmienne
│   └── integrations/
│       ├── github-examples.md   # Przykłady GitHub
│       ├── database-examples.md # Przykłady baz danych
│       └── other-integrations.md
├── scripts/
│   ├── setup.sh                 # Automatyczna konfiguracja
│   ├── test-server.sh          # Testowanie serwerów
│   └── setup-database.sh       # Setup bazy SQLite
├── .mcp.json                    # Konfiguracja serwerów MCP
├── .env.example                 # Template zmiennych środowiskowych
└── .gitignore                   # Bezpieczeństwo
```

## Budowanie tutoriala

Jeśli chcesz zbudować tutorial samodzielnie:

```bash
# Zainstaluj coderoad-cli
npm install -g @coderoad/coderoad-cli

# Zbuduj tutorial
coderoad build
```

To wygeneruje plik `tutorial.json` gotowy do użycia w CodeRoad.

## Szybki start

Po przejściu tutoriala, możesz od razu używać przykładów:

```bash
# Setup projektu
bash scripts/setup.sh

# Test weather-server
bash scripts/test-server.sh

# Setup bazy danych
bash scripts/setup-database.sh

# Otwórz w Claude Code i zapytaj:
# "Jaka jest pogoda w Warszawie?"
# "Pokaż wszystkie tabele w bazie SQLite"
```

## Dlaczego CodeRoad?

CodeRoad to idealne narzędzie do nauki MCP, ponieważ:
- ✅ Automatycznie wdraża kod w każdym kroku
- ✅ Pokazuje progresję od podstaw do zaawansowanych
- ✅ Integruje się z VS Code
- ✅ Pozwala eksperymentować z kodem na żywo
- ✅ Nie wymaga ręcznego kopiowania kodu

## Licencja

MIT

## Autor

Tutorial przygotowany jako materiał edukacyjny dla projektu Efektywniejsi.
