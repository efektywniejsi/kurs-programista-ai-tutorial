# Integracja baz danych z MCP

MCP umożliwia Claude Code bezpośredni dostęp do baz danych. To potężna funkcja do analizy danych i debugowania.

## SQLite - Lokalna baza danych

### Konfiguracja

SQLite jest już skonfigurowany w `.mcp.json`:

```json
"sqlite": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-sqlite", "./data/example.db"],
  "transport": "stdio",
  "description": "Dostęp do lokalnej bazy SQLite",
  "scope": "project"
}
```

### Tworzenie przykładowej bazy

Stwórzmy przykładową bazę danych:

```bash
# Utwórz katalog data jeśli nie istnieje
mkdir -p data

# Utwórz bazę SQLite
sqlite3 data/example.db << EOF
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    role TEXT DEFAULT 'user',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE projects (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT,
    owner_id INTEGER,
    status TEXT DEFAULT 'active',
    FOREIGN KEY (owner_id) REFERENCES users(id)
);

INSERT INTO users (name, email, role) VALUES
    ('Jan Kowalski', 'jan@example.com', 'admin'),
    ('Anna Nowak', 'anna@example.com', 'developer'),
    ('Piotr Wiśniewski', 'piotr@example.com', 'developer');

INSERT INTO projects (name, description, owner_id, status) VALUES
    ('MCP Tutorial', 'Interactive tutorial for MCP', 1, 'active'),
    ('Weather API', 'Simple weather service', 2, 'active'),
    ('Data Analytics', 'Analytics dashboard', 2, 'planning');
EOF

echo "✅ Przykładowa baza danych utworzona w data/example.db"
```

### Możliwości

**Przykładowe zapytania:**
- "Pokaż wszystkich użytkowników z bazy"
- "Ile projektów jest w statusie 'active'?"
- "Kto jest właścicielem projektu 'MCP Tutorial'?"
- "Dodaj nowego użytkownika: Maria Kowalczyk, maria@example.com"

**Co możesz zrobić:**
- 📊 Wykonywanie zapytań SELECT
- ➕ Wstawianie danych (INSERT)
- ✏️ Aktualizacja danych (UPDATE)
- 🗑️ Usuwanie danych (DELETE)
- 🏗️ Analiza struktury tabel
- 📈 Agregacje i statystyki

---

## PostgreSQL - Produkcyjna baza danych

### Konfiguracja

PostgreSQL wymaga osobnej instalacji. Dodaj do `.mcp.json`:

```json
"postgres": {
  "command": "npx",
  "args": [
    "-y",
    "@modelcontextprotocol/server-postgres",
    "${DATABASE_URL}"
  ],
  "transport": "stdio",
  "description": "PostgreSQL database access",
  "scope": "project",
  "env": {
    "DATABASE_URL": "${DATABASE_URL}"
  }
}
```

### Ustawienie DATABASE_URL

W pliku `.env`:

```bash
# Lokalna baza
DATABASE_URL=postgresql://user:password@localhost:5432/database

# Lub z serwisu jak Supabase/Render
DATABASE_URL=postgresql://user:pass@host.example.com:5432/db?sslmode=require
```

### Bezpieczeństwo dla PostgreSQL

⚠️ **WAŻNE:** Dla bezpieczeństwa, używaj użytkownika tylko-do-odczytu:

```sql
-- Utwórz użytkownika tylko-do-odczytu
CREATE USER claude_readonly WITH PASSWORD 'secure_password';

-- Daj uprawnienia do odczytu
GRANT CONNECT ON DATABASE your_db TO claude_readonly;
GRANT USAGE ON SCHEMA public TO claude_readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO claude_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO claude_readonly;
```

Używaj tego użytkownika w DATABASE_URL:

```bash
DATABASE_URL=postgresql://claude_readonly:secure_password@localhost:5432/your_db
```

---

## Przykładowe Workflow

### Analiza danych

1. **Przegląd tabel:**
   ```
   "Jakie tabele są w bazie SQLite?"
   ```

2. **Eksploracja danych:**
   ```
   "Pokaż strukturę tabeli users"
   "Ile rekordów jest w każdej tabeli?"
   ```

3. **Analiza:**
   ```
   "Którzy użytkownicy mają najwięcej projektów?"
   "Pokaż rozkład statusów projektów"
   ```

4. **Export:**
   ```
   "Exportuj wszystkich userów do JSON"
   ```

### Debugowanie

1. **Znajdź problem:**
   ```
   "Pokaż użytkowników bez przypisanych projektów"
   "Które projekty mają invalid owner_id?"
   ```

2. **Napraw:**
   ```
   "Zaktualizuj status projektu 'Data Analytics' na 'active'"
   ```

3. **Zweryfikuj:**
   ```
   "Sprawdź czy wszystkie projekty mają poprawnego ownera"
   ```

---

## Best Practices

### Bezpieczeństwo

🔐 **Dla produkcji:**
- ✅ Używaj użytkownika tylko-do-odczytu
- ✅ Nigdy nie dawaj uprawnień DROP/DELETE w produkcji
- ✅ Używaj oddzielnej bazy dla developmentu
- ✅ Regularnie backupuj dane

🔐 **Dla developmentu:**
- ✅ Używaj lokalnej bazy (SQLite)
- ✅ Testuj na kopii danych
- ✅ Nie używaj prawdziwych danych klientów

### Performance

- 📊 Limituj wyniki dużych zapytań (LIMIT)
- 📊 Używaj indeksów dla często odpytywanych kolumn
- 📊 Monitoruj long-running queries

### Organizacja

- 📁 SQLite - świetny dla lokalnych projektów, testów, cache
- 📁 PostgreSQL - dla produkcji, współdzielonych danych
- 📁 Oddziel DEV/STAGING/PROD bazy

---

## Inne bazy danych

### MySQL/MariaDB

Użyj serwera PostgreSQL (kompatybilny):

```json
"mysql": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-postgres", "${MYSQL_URL}"],
  "env": {
    "MYSQL_URL": "mysql://user:pass@localhost:3306/db"
  }
}
```

### MongoDB

Obecnie brak oficjalnego serwera, ale możesz stworzyć własny! Zobacz dokumentację MCP.

---

## Skrypt setup bazy

Dodajmy skrypt do automatycznego setupu bazy:

```bash
# scripts/setup-database.sh
#!/bin/bash

echo "🗄️  Setup przykładowej bazy SQLite..."

mkdir -p data

sqlite3 data/example.db << EOF
-- Twoja schema i dane tutaj
EOF

echo "✅ Baza gotowa: data/example.db"
```

---

## Zadania do wykonania

1. ✅ Uruchom skrypt tworzący bazę SQLite
2. ✅ Sprawdź czy plik `data/example.db` istnieje
3. ✅ Zrestartuj Claude Code
4. 🧪 Wypróbuj: "Pokaż wszystkie tabele w bazie SQLite"
5. 🧪 Wypróbuj: "Ile użytkowników jest w bazie?"
6. 🧪 Wypróbuj: "Pokaż projekty z ich właścicielami (JOIN)"

🎉 Gratulacje! Masz działającą integrację z bazą danych!

---

## Dodatkowe zasoby

- [SQLite Documentation](https://www.sqlite.org/docs.html)
- [PostgreSQL Tutorial](https://www.postgresql.org/docs/current/tutorial.html)
- [SQL Best Practices](https://www.sqlstyle.guide/)
