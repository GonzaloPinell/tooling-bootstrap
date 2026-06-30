---
description: Refina REQUIREMENTS.md y configura el tooling del proyecto (skills/plugins/MCPs) de forma NO destructiva e idempotente, distinguiendo global vs local.
argument-hint: "[--yes] [--dry-run] [ruta/a/REQUIREMENTS.md]"
allowed-tools: Bash, Read, Write, Edit, Glob, Grep, AskUserQuestion, Skill, Task
---

# /bootstrap — Configura el tooling del proyecto

Eres el orquestador de `tooling-bootstrap`. Tu trabajo es dejar el proyecto con el
tooling de agente (Skills, Plugins, MCPs) correctamente configurado a partir de un
`REQUIREMENTS.md` sólido. **Nunca borras ni desinstalas nada.**

Argumentos recibidos: `$ARGUMENTS`
- `--yes` → asume confirmación solo en **escrituras locales seguras** dentro del repo.
  **Nunca** auto-confirma instalaciones a nivel usuario/global (`claude plugin install`,
  `npx skills add`, `claude mcp add -s user`, `brew`/`uv`): esas **siempre** requieren
  confirmación explícita.
- `--dry-run` → produce el manifiesto y los artefactos, pero NO instala/declara nada.
- Una ruta opcional a un archivo de requerimientos (por defecto: `REQUIREMENTS.md`, y si no, `foundation.md`).

> Las rutas a archivos internos del plugin (skills/scripts/plantillas) se referencian
> con `${CLAUDE_PLUGIN_ROOT}` porque al ejecutar este comando el directorio de trabajo
> es el **proyecto del usuario**, no la raíz del plugin.

## Reglas innegociables (recuérdalas en cada paso)
- **No destructivo**: prohibido `uninstall`, `remove`, `rm`, vaciar settings, sobreescribir sin respaldo.
- **Idempotente**: re-ejecutar no duplica ni rompe nada. Inventaría antes de instalar.
- **Portable**: lo local se versiona en git; nunca escribas config de proyecto en `settings.local.json`.
- **Honesto con orígenes**: si no sabes el repo de una skill, márcala "a confirmar" (`npx skills find`), no lo inventes.

## Procedimiento

Carga y sigue la skill **`tooling-bootstrap`** (contiene la filosofía global/local,
las 5 categorías A–E, los 3 tipos y el algoritmo detallado con criterios de decisión).
Ejecuta su algoritmo en este orden:

### Paso 0 — Garantizar un REQUIREMENTS.md sólido (gate de refinamiento)
1. Localiza el archivo de requerimientos (arg → `REQUIREMENTS.md` → `foundation.md`).
2. Si **no existe**: explica cómo crearlo y ofrece la plantilla
   (`${CLAUDE_PLUGIN_ROOT}/skills/tooling-bootstrap/reference/REQUIREMENTS.template.md`).
   Pregunta si quieres que arranquemos el refinamiento desde cero. **No instales nada.**
3. Si existe pero está **incompleto o pobre** (faltan secciones clave: dominio,
   usuarios, stack, datos, no-objetivos, seguridad, escala): **invoca la skill
   `requirements-refiner`** (equivalente a `/refine-requirements`) para una ronda
   exhaustiva de preguntas + inferencia, y obtener un `REQUIREMENTS.md` refinado
   antes de continuar.
4. Solo cuando el `REQUIREMENTS.md` es sólido, continúa.

> Si el usuario pasó `--yes` pero el archivo está pobre, **igual** corre el
> refinamiento: la calidad del manifiesto depende por completo de esta base.

### Paso 1 — Analizar requerimientos e inferir
Extrae dominio/tópico, stack (lenguajes/frameworks/librerías), necesidades de
diseño y de planeación. Usa el subagente `stack-detector` y/o
`bash ${CLAUDE_PLUGIN_ROOT}/scripts/inventory.sh` y
`${CLAUDE_PLUGIN_ROOT}/skills/tooling-bootstrap/reference/stack-map.md` para mapear
stack → candidatos.

### Paso 2 — Proponer el manifiesto y PEDIR CONFIRMACIÓN
Construye una tabla por **categoría (A–E)** × **tipo (skill/plugin/mcp)** ×
**nivel (global/local)** con justificación. Muéstrala y **pide confirmación**
antes de instalar. No instales nada todavía.

### Paso 3 — Inventariar lo ya instalado (sin tocar nada)
`claude plugin list`, `claude mcp list`, `ls ~/.claude/skills`, `ls .claude/skills`
(o `bash ${CLAUDE_PLUGIN_ROOT}/scripts/inventory.sh`). Marca lo que ya existe para
**no reinstalar**.

### Paso 4 — Instalar/declarar SOLO lo que falte
- **Global** (nivel usuario, project-agnostic): `claude plugin install …@… -y`,
  `npx skills add <repo>`, `claude mcp add <nombre> -s user …`, CLIs vía `brew`/`uv`.
- **Local** (en el repo): `extraKnownMarketplaces` + `enabledPlugins` en
  `.claude/settings.json`, skills en `.claude/skills/`, MCP en `.mcp.json`.
  **Fusiona, no reemplaces** el JSON existente; si el archivo ya tenía contenido,
  respáldalo antes (`*.bak-AAAAMMDD-HHMM`) o verifica que el repo esté limpio en git.
  Comprueba que esos paths **no estén gitignored** (`git check-ignore .claude .mcp.json`);
  si lo están, avisa: el tooling local no viajará a otra máquina pese a lo prometido.
- **Confirmación:** toda instalación **global / a nivel usuario** requiere OK
  explícito del usuario, **aunque** se haya pasado `--yes` (que solo cubre escrituras
  locales en el repo).
- Con `--dry-run`: no ejecutes, solo lista lo que harías.

### Paso 5 — Crear skills propias (categoría E)
Solo cuando la decisión de producto está tomada, créalas con `skill-creator` +
`superpowers:writing-skills`. Si no, regístralas como **pendientes** en `TOOLING.md`
(no crees placeholders vacíos).

### Paso 6 — Generar/actualizar artefactos
- `TOOLING.md` (manifiesto del proyecto) usando
  `${CLAUDE_PLUGIN_ROOT}/skills/tooling-bootstrap/reference/TOOLING.template.md`.
- Sección **Setup** del `README.md`: comandos para reinstalar lo **global** + lista
  de lo **local** ya versionado, usando
  `${CLAUDE_PLUGIN_ROOT}/skills/tooling-bootstrap/reference/README-setup.snippet.md`.

### Paso 7 — Resumen final
Qué se instaló y dónde, qué quedó pendiente, y cómo verificar (reabrir en otra
máquina + seguir el README global ⇒ mismo tooling).

## Recordatorio
Ante ambigüedad real, **pregunta**. Ante una acción destructiva, **niégate** y
explica que la limpieza es manual y queda fuera de este plugin.
