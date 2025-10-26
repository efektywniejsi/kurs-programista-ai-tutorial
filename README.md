# Tutorial MCP dla CodeRoad

Interaktywny tutorial o **Model Context Protocol (MCP)** przygotowany dla rozszerzenia CodeRoad w VS Code.

## Czego się nauczysz?

- Podstawy Model Context Protocol
- Instalacja i konfiguracja serwerów MCP
- Integracje z popularnymi usługami (GitHub, bazy danych, Sentry)
- Zarządzanie serwerami MCP

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

1. **Wprowadzenie do MCP** - Podstawy, architektura, rodzaje transportu
2. **Instalacja i konfiguracja** - Dodawanie serwerów, zakresy, zarządzanie
3. **Popularne integracje** - GitHub, bazy danych, inne usługi

## Budowanie tutoriala

Jeśli chcesz zbudować tutorial samodzielnie:

```bash
# Zainstaluj coderoad-cli
npm install -g @coderoad/coderoad-cli

# Zbuduj tutorial
coderoad build
```

To wygeneruje plik `tutorial.json` gotowy do użycia w CodeRoad.

## Wymagania techniczne

Ten tutorial jest głównie edukacyjny i nie wymaga pisania kodu. Skupia się na nauce koncepcji MCP i praktycznych komendach CLI.

## Licencja

MIT

## Autor

Tutorial przygotowany jako materiał edukacyjny dla projektu Efektywniejsi.
