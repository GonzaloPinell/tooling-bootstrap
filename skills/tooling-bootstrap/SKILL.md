---
name: tooling-bootstrap
description: Configura inteligentemente el tooling de un proyecto (Skills, Plugins, MCPs) a partir de su REQUIREMENTS.md — decide qué va global vs local, lo instala/declara de forma no destructiva e idempotente, crea las skills propias del proyecto y genera TOOLING.md + la sección Setup del README. Úsala cuando arranques un proyecto, ejecutes /bootstrap, o quieras estandarizar el tooling del agente para mejorar el flujo de trabajo de la IA.
---

# tooling-bootstrap — La metodología

Esta skill codifica una metodología para dejar un proyecto con el **tooling de agente
adecuado** desde el día uno. Lee `REQUIREMENTS.md`, infiere qué necesita el proyecto,
y deja Skills/Plugins/MCPs configurados **distinguiendo lo global de lo local**.

> **Alcance:** instalar, declarar, crear y documentar. **NUNCA** desinstalar ni borrar.
> La limpieza es siempre manual y queda fuera de esta skill.

## Invariantes (aplican en todo momento)

1. **No destructivo.** Prohibido `uninstall`, `remove`, `rm`, vaciar settings, o
   sobreescribir un archivo sin respaldo. Ante una petición destructiva, niégate y
   explica que la limpieza es manual.
2. **Idempotente.** Inventaría antes de actuar. Re-ejecutar no duplica plugins, no
   re-agrega MCPs, no re-instala skills, no rompe settings.
3. **Portable.** Lo local se versiona en git (`.claude/skills`, `.claude/settings.json`,
   `.mcp.json`). **Nunca** escribas config de proyecto en `settings.local.json`
   (gitignored). Lo global se reinstala siguiendo comandos documentados en el README.
4. **Honesto con orígenes.** Si no puedes determinar el repo/origen de una skill,
   márcalo "a confirmar" y usa `npx skills find` — no inventes URLs ni nombres.
5. **Confirmación antes de instalar global.** Muestra el manifiesto y pide OK antes
   de tocar el nivel usuario. `--yes` solo cubre escrituras **locales** en el repo;
   **nunca** auto-confirma instalaciones a nivel usuario.

## Filosofía

### Global vs Local (para Skills, Plugins y MCPs)
- **Global (nivel usuario):** reutilizable en todos los proyectos. Se instala **una vez**
  en la máquina y se **documenta en el README** del proyecto (con el comando para reinstalar).
- **Local (en el repo):** propio del proyecto. Se **versiona en git** para que viaje con el repo.

Criterio de decisión rápido:
> *¿Lo usarías igual en otro proyecto distinto?* → **Global.**
> *¿Codifica una decisión, dominio o convención de ESTE producto?* → **Local.**

### Las 5 categorías
| Cat | Nombre | Nivel típico | Contenido |
|-----|--------|--------------|-----------|
| **A** | Planeación, calidad y seguridad | Global | Metodología (superpowers, spec-kit, gh) + ciberseguridad (`security-guidance`, `/security-review`) + estándares de ingeniería (skill `engineering-standards`: Clean Architecture, SOLID, componentización, modularización, testing, DRY/YAGNI/KISS). |
| **B** | Diseño | Global | El set de diseño habitual del usuario *(configurable — ver `reference/taxonomy.md`)*. |
| **C** | Tecnologías | Global | Según el stack detectado (React, Tailwind, TS, Flutter, Rust…). |
| **D** | Tópico / dominio | Local | Conocimiento del área del producto. Si no existe una skill pública adecuada → pasa a **E**. |
| **E** | Autoría propia | Local | Skills que codifican decisiones del producto. Se crean con `skill-creator`. |

### Los 3 tipos
- **Skill** — conocimiento/procedimiento que el agente activa por descripción.
- **Plugin** — paquete (commands + skills + agents + hooks + MCP) vía marketplace.
- **MCP** — servidor que aporta herramientas/datos externos (stdio o http).

Detalle completo y tabla de decisión: `reference/taxonomy.md`.
Mapa stack → candidatos: `reference/stack-map.md`.

## Algoritmo (lo que ejecuta `/bootstrap`)

### Paso 0 — Gate de refinamiento de REQUIREMENTS.md
- Localiza el archivo (`REQUIREMENTS.md` → si no, `foundation.md`).
- **No existe** → detente; ofrece `reference/REQUIREMENTS.template.md` y explica cómo crearlo. No instales nada.
- **Existe pero pobre/incompleto** → invoca la skill `requirements-refiner` para una
  ronda exhaustiva de preguntas + inferencia, y obtener una base sólida.
- Solo con un `REQUIREMENTS.md` sólido continúas. *La calidad de todo lo demás depende de esto.*

### Paso 1 — Analizar e inferir
- Extrae **dominio/tópico**, **stack**, necesidades de **diseño** y de **planeación**.
- Usa el subagente `stack-detector` (lee `package.json`, `pubspec.yaml`, `Cargo.toml`,
  `pyproject.toml`, etc.) y `reference/stack-map.md`.
- Respeta exclusiones explícitas del REQUIREMENTS (p. ej. "no Next.js" ⇒ no propongas Next).

### Paso 2 — Proponer manifiesto + confirmar
- Tabla **categoría (A–E) × tipo (skill/plugin/mcp) × nivel (global/local)** con
  justificación y origen (o "a confirmar").
- Muéstrala y **pide confirmación** antes de instalar. Respeta `--dry-run`.

### Paso 3 — Inventariar (sin tocar nada)
- `claude plugin list`, `claude mcp list`, `ls ~/.claude/skills`, `ls .claude/skills`
  (o `bash ${CLAUDE_PLUGIN_ROOT}/scripts/inventory.sh`). Marca lo ya presente para **no reinstalar**.

### Paso 4 — Instalar/declarar solo lo que falte
- **Global:** `claude plugin install <plugin>@<marketplace> -y`, `npx skills add <repo>`,
  `claude mcp add <nombre> -s user …`, CLIs vía `brew install …` / `uv tool install …`.
  Marketplaces de terceros: `claude plugin marketplace add <owner/repo>` antes de instalar.
- **Local:** edita/crea `.claude/settings.json` (`extraKnownMarketplaces` + `enabledPlugins`),
  coloca skills en `.claude/skills/<nombre>/SKILL.md`, declara MCP en `.mcp.json`.
  **Fusiona, no reemplaces** JSON existente (idempotencia). Si el archivo ya tenía
  contenido, **respáldalo antes** (`*.bak-AAAAMMDD-HHMM`) o confirma repo git limpio.
  Verifica que `.claude/` y `.mcp.json` **no estén gitignored**
  (`git check-ignore .claude .mcp.json`); si lo están, avisa: el tooling local no viajará.

### Paso 5 — Crear skills propias (cat. E)
- Solo si la decisión de producto está tomada: usa el plugin `skill-creator` y la skill
  `superpowers:writing-skills`. Si no, **regístralas como pendientes** en `TOOLING.md`
  (no crees placeholders vacíos).

### Paso 6 — Generar/actualizar artefactos
- `TOOLING.md` desde `reference/TOOLING.template.md` (estado de cada categoría, nivel,
  origen, y pendientes).
- Sección **Setup** del `README.md` desde `reference/README-setup.snippet.md`:
  comandos para reinstalar lo **global** + lista de lo **local** ya versionado.
  Si el README ya tiene esa sección, **actualízala en sitio** (no la dupliques);
  respáldalo antes si tiene cambios sin commitear.

### Paso 7 — Resumen final
- Qué se instaló y dónde (global vs local), qué quedó pendiente, y cómo verificar:
  reabrir el proyecto en otra máquina + seguir el README global ⇒ mismo tooling.

## Verificación de idempotencia (antes de escribir cualquier cosa)
- ¿El plugin/MCP/skill ya aparece en el inventario? → no lo reinstales.
- ¿El bloque ya existe en el JSON/README destino? → fusiónalo/actualízalo, no lo dupliques.
- ¿Vas a sobreescribir **o fusionar/editar en sitio** un archivo preexistente del usuario
  (`settings.json` / `.mcp.json` / `README`)? → respáldalo primero (`*.bak-<fecha>`) o confirma git limpio.
- ¿Los paths locales (`.claude/`, `.mcp.json`) están gitignored? → avisa: no viajarán a otra máquina.

## Referencias incluidas
- `reference/taxonomy.md` — categorías A–E, 3 tipos, regla global/local, placeholder de diseño (cat. B).
- `reference/stack-map.md` — stack detectado → skills/plugins/mcps candidatos.
- `reference/REQUIREMENTS.template.md` — plantilla del documento de entrada.
- `reference/TOOLING.template.md` — plantilla del manifiesto del proyecto.
- `reference/README-setup.snippet.md` — snippet de la sección Setup del README.
