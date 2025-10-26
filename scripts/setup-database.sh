#!/bin/bash

# Skrypt do tworzenia przykładowej bazy SQLite

echo "🗄️  Tworzenie przykładowej bazy SQLite..."
echo ""

# Utwórz katalog data
mkdir -p data

# Sprawdź czy SQLite jest dostępny
if ! command -v sqlite3 &> /dev/null; then
    echo "⚠️  SQLite3 nie jest zainstalowany"
    echo "   macOS: brew install sqlite"
    echo "   Ubuntu: sudo apt-get install sqlite3"
    exit 1
fi

# Utwórz bazę danych
sqlite3 data/example.db << 'EOF'
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    role TEXT DEFAULT 'user',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS projects (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT,
    owner_id INTEGER,
    status TEXT DEFAULT 'active',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (owner_id) REFERENCES users(id)
);

-- Usuń istniejące dane (dla czystego startu)
DELETE FROM projects;
DELETE FROM users;

-- Dodaj przykładowych użytkowników
INSERT INTO users (name, email, role) VALUES
    ('Jan Kowalski', 'jan@example.com', 'admin'),
    ('Anna Nowak', 'anna@example.com', 'developer'),
    ('Piotr Wiśniewski', 'piotr@example.com', 'developer'),
    ('Maria Kowalczyk', 'maria@example.com', 'user');

-- Dodaj przykładowe projekty
INSERT INTO projects (name, description, owner_id, status) VALUES
    ('MCP Tutorial', 'Interactive tutorial for Model Context Protocol', 1, 'active'),
    ('Weather API', 'Simple weather service with MCP', 2, 'active'),
    ('Data Analytics', 'Analytics dashboard for metrics', 2, 'planning'),
    ('Mobile App', 'React Native mobile application', 3, 'active'),
    ('Legacy Migration', 'Migrating old codebase', 3, 'completed');

.tables
.schema users
.schema projects
EOF

echo ""
echo "✅ Baza danych utworzona: data/example.db"
echo ""
echo "📊 Statystyki:"
sqlite3 data/example.db "SELECT COUNT(*) || ' użytkowników' FROM users; SELECT COUNT(*) || ' projektów' FROM projects;"
echo ""
echo "🧪 Możesz teraz zapytać Claude:"
echo "   - 'Pokaż wszystkie tabele w bazie SQLite'"
echo "   - 'Ile użytkowników jest w bazie?'"
echo "   - 'Pokaż projekty z ich właścicielami'"
