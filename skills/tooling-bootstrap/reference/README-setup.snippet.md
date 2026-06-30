<!--
Snippet para la sección "Setup / Tooling del agente" del README del proyecto.
La genera/actualiza `tooling-bootstrap`. Si ya existe, se actualiza EN SITIO (no se duplica).
Sustituye los <placeholders> por lo realmente instalado. Lo LOCAL ya viaja en el repo;
aquí solo se documenta lo GLOBAL (nivel usuario), que cada máquina debe reinstalar.
-->

## Setup del tooling de agente (Claude Code)

Este proyecto usa Claude Code con tooling configurado por
[`tooling-bootstrap`](https://github.com/gonzalopinell/tooling-bootstrap). El tooling
**local** ya está versionado en el repo (`.claude/`, `.mcp.json`) y se activa solo al
abrir el proyecto. El tooling **global** se instala una vez por máquina con los
comandos de abajo.

### 1. Requisitos
- [Claude Code](https://claude.com/claude-code) instalado y autenticado.
- `node`/`npx`, `git`, `gh` y (opcional) `brew` / `uv`.

### 2. Tooling global (reinstalar en cada máquina)

```bash
# Marketplaces de terceros (si aplica)
claude plugin marketplace add <owner/repo>

# Plugins globales
claude plugin install <plugin>@<marketplace>
# p. ej.: superpowers, spec-kit, skill-creator, security-*

# Skills globales (categorías A/B/C)
npx skills add <repo-de-la-skill>
# p. ej.: engineering-standards, <skills de stack>, <set de diseño>

# MCPs globales (transversales)
claude mcp add <nombre> -s user -- <comando-del-servidor>

# CLIs de apoyo
# brew install gh
# uv tool install specify-cli   # spec-kit
```

> Reemplaza cada `<placeholder>` por lo que aparezca en `TOOLING.md`. Lo marcado
> "a confirmar" se resuelve con `npx skills find <término>`.

### 3. Tooling local (ya en el repo)
- `.claude/skills/` — skills propias del proyecto (categorías D/E). **Autocontenido** (viaja en git).
- `.mcp.json` — MCPs propios del proyecto (p. ej. su base de datos). **Autocontenido.**
- `.claude/settings.json` — `extraKnownMarketplaces` + `enabledPlugins` del proyecto.
  Nota: un **plugin local** se *declara* aquí, pero su código se **descarga del marketplace**
  al abrir el proyecto por primera vez (requiere conectividad esa vez); no se vendoriza en el repo.

### 4. Verificación
```bash
claude plugin list      # plugins activos
claude mcp list         # MCPs disponibles
ls .claude/skills       # skills locales del repo
```
Reabrir el proyecto en otra máquina + seguir estos pasos ⇒ **mismo tooling**.
Detalle completo en [`TOOLING.md`](./TOOLING.md).
