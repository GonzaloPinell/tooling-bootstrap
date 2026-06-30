# Mapa stack → herramientas candidatas (categoría C)

Heurísticas para mapear el stack detectado a skills/plugins/MCPs **candidatos**.
Esto es un punto de partida, **no** una lista para instalar a ciegas:
- Propón solo lo que el proyecto realmente use.
- Respeta exclusiones del `REQUIREMENTS.md` ("no Next.js" ⇒ no propongas Next).
- Donde el origen no sea seguro, márcalo **`origen: a confirmar`** y resuélvelo con
  `npx skills find <término>`. **No inventes** repos.

## Señales de detección (archivos del repo)

| Archivo | Indica | Cómo leerlo |
|---------|--------|-------------|
| `package.json` (`dependencies`/`devDependencies`) | JS/TS y frameworks | react, react-native, expo, vue, svelte, angular, next, nuxt, remix, astro, solid, vite, electron, ionic, capacitor, tailwind, shadcn, zustand, redux, playwright, vitest, jest, express, nest, prisma, drizzle |
| `pnpm-lock.yaml` / `yarn.lock` / `bun.lockb` | gestor de paquetes JS | pnpm / yarn / bun |
| `tsconfig.json` | TypeScript | — |
| `pubspec.yaml` | Flutter / Dart | — |
| `Cargo.toml` | Rust | — |
| `pyproject.toml` / `requirements.txt` | Python | django, flask, fastapi, pandas, pytorch |
| `go.mod` | Go | — |
| `composer.json` | PHP / Laravel | — |
| `Gemfile` | Ruby / Rails | — |
| `*.csproj` / `*.sln` | .NET / C# | — |
| `pom.xml` / `build.gradle(.kts)` | Java / Kotlin / Spring | — |
| `*.xcodeproj` / `Package.swift` | Swift / iOS nativo | — |
| `AndroidManifest.xml` | Android (Kotlin/Java) | — |
| `Dockerfile` / `compose.yaml` | contenedores | — |
| `.github/workflows/` | CI GitHub Actions | — |

> La detección real de stack la hace el subagente
> `${CLAUDE_PLUGIN_ROOT}/agents/stack-detector.md` (lee dependencias y mapea tecnologías).
> `${CLAUDE_PLUGIN_ROOT}/scripts/inventory.sh` solo aporta una señal gruesa de **presencia**
> de manifiestos; no sustituye al subagente para el mapeo tecnología → candidatos.

## Tecnología → candidatos (rellenar origen con `npx skills find`)

| Tecnología detectada | Candidato (tipo) | Nivel | Origen |
|----------------------|------------------|-------|--------|
| TypeScript | skill de buenas prácticas TS | global | a confirmar |
| React | skill React/hooks/patrones | global | a confirmar |
| Next.js | skill Next (app router, RSC) | global | a confirmar |
| Vue / Nuxt | skill Vue/Nuxt | global | a confirmar |
| Svelte / SvelteKit | skill Svelte | global | a confirmar |
| Angular | skill Angular | global | a confirmar |
| Astro | skill Astro (SSG/islands) | global | a confirmar |
| Tailwind CSS | skill Tailwind | global | a confirmar |
| shadcn/ui | skill componentes shadcn | global | a confirmar |
| Zustand / Redux | skill manejo de estado | global | a confirmar |
| Electron | skill Electron | global | a confirmar |
| Tauri | skill Tauri (desktop Rust) | global | a confirmar |
| React Native / Expo | skill RN/Expo | global | a confirmar |
| Flutter / Dart | skill Flutter | global | a confirmar |
| Ionic / Capacitor | skill Ionic/Capacitor | global | a confirmar |
| Swift / iOS nativo | skill iOS/Swift | global | a confirmar |
| Android (Kotlin) | skill Android | global | a confirmar |
| Rust | skill Rust | global | a confirmar |
| Node backend (NestJS / Express) | skill backend Node | global | a confirmar |
| Python / FastAPI / Django | skill Python/framework | global | a confirmar |
| Go | skill Go | global | a confirmar |
| Java / Kotlin / Spring | skill JVM/Spring | global | a confirmar |
| .NET / C# | skill .NET/ASP.NET | global | a confirmar |
| PHP / Laravel | skill PHP/Laravel | global | a confirmar |
| Ruby / Rails | skill Ruby/Rails | global | a confirmar |
| Playwright / Vitest / Jest | skill testing E2E/unit | global | a confirmar |
| Prisma / Drizzle | skill ORM + MCP de DB | global / local | a confirmar |
| PostgreSQL / SQLite / MySQL | **MCP** de base de datos | local (`.mcp.json`) | a confirmar |
| GitHub | `gh` CLI + MCP de GitHub | global | gh (oficial) / a confirmar |
| Docker | skill contenedores | global | a confirmar |
| Navegador / scraping | MCP de browser (p. ej. Playwright/Chrome) | local | a confirmar |

## MCPs frecuentes por necesidad

| Necesidad declarada | MCP candidato | Nivel |
|---------------------|---------------|-------|
| Consultar/operar la base de datos del proyecto | MCP de la DB concreta | local (`.mcp.json`) |
| Automatizar navegador / scraping / E2E | MCP de browser | local |
| Operar GitHub (issues/PRs) | MCP/`gh` | global |
| Buscar en documentación / web | MCP de búsqueda | global o local |
| Sistema de archivos acotado | MCP filesystem | local |

> Regla: un MCP **propio del proyecto** (su DB, su browser de scraping) va **local**
> en `.mcp.json`; un MCP **transversal** (GitHub, búsqueda) va **global** (`-s user`).
