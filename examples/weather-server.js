#!/usr/bin/env node

/**
 * Prosty przykładowy serwer MCP - Weather Server
 *
 * Ten serwer demonstruje podstawową strukturę serwera MCP.
 * Udostępnia narzędzie do sprawdzania pogody.
 */

const TOOLS = [
  {
    name: "get_weather",
    description: "Pobiera informacje o pogodzie dla podanego miasta",
    inputSchema: {
      type: "object",
      properties: {
        city: {
          type: "string",
          description: "Nazwa miasta"
        }
      },
      required: ["city"]
    }
  }
];

// Symulowane dane pogodowe
const WEATHER_DATA = {
  "Warszawa": { temp: 15, condition: "Pochmurno", humidity: 65 },
  "Kraków": { temp: 17, condition: "Słonecznie", humidity: 55 },
  "Gdańsk": { temp: 12, condition: "Deszczowo", humidity: 80 },
  "Wrocław": { temp: 16, condition: "Słonecznie", humidity: 60 }
};

/**
 * Obsługa żądania MCP
 */
function handleRequest(request) {
  const { method, params } = request;

  switch (method) {
    case "tools/list":
      return {
        jsonrpc: "2.0",
        id: request.id,
        result: { tools: TOOLS }
      };

    case "tools/call":
      const { name, arguments: args } = params;

      if (name === "get_weather") {
        const city = args.city;
        const weather = WEATHER_DATA[city];

        if (!weather) {
          return {
            jsonrpc: "2.0",
            id: request.id,
            result: {
              content: [{
                type: "text",
                text: `Brak danych pogodowych dla miasta: ${city}`
              }]
            }
          };
        }

        return {
          jsonrpc: "2.0",
          id: request.id,
          result: {
            content: [{
              type: "text",
              text: `Pogoda w ${city}:\n🌡️ Temperatura: ${weather.temp}°C\n☁️ Warunki: ${weather.condition}\n💧 Wilgotność: ${weather.humidity}%`
            }]
          }
        };
      }

      return {
        jsonrpc: "2.0",
        id: request.id,
        error: {
          code: -32601,
          message: "Nieznane narzędzie"
        }
      };

    case "initialize":
      return {
        jsonrpc: "2.0",
        id: request.id,
        result: {
          protocolVersion: "0.1.0",
          serverInfo: {
            name: "weather-server",
            version: "1.0.0"
          },
          capabilities: {
            tools: {}
          }
        }
      };

    default:
      return {
        jsonrpc: "2.0",
        id: request.id,
        error: {
          code: -32601,
          message: "Nieznana metoda"
        }
      };
  }
}

/**
 * Główna funkcja serwera (Stdio transport)
 */
function main() {
  let buffer = "";

  process.stdin.on("data", (chunk) => {
    buffer += chunk.toString();

    // Przetwarzaj kompletne linie JSON-RPC
    const lines = buffer.split("\n");
    buffer = lines.pop(); // Zachowaj niekompletną linię

    for (const line of lines) {
      if (line.trim()) {
        try {
          const request = JSON.parse(line);
          const response = handleRequest(request);
          process.stdout.write(JSON.stringify(response) + "\n");
        } catch (error) {
          console.error("Błąd parsowania:", error);
        }
      }
    }
  });

  process.stdin.on("end", () => {
    process.exit(0);
  });
}

// Uruchom serwer
if (require.main === module) {
  main();
}

module.exports = { handleRequest, TOOLS, WEATHER_DATA };
