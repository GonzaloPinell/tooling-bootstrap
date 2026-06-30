# TOOLING — <Nombre del proyecto>

> Manifiesto del tooling de agente del proyecto, generado por `tooling-bootstrap`.
> **Global** = instalado a nivel usuario (reinstalable vía README). **Local** = versionado en este repo.
> Generado/actualizado: `<fecha>` · Base: `REQUIREMENTS.md`

## Resumen por categoría

| Cat | Categoría | Tipo | Nombre | Nivel | Origen | Estado |
|-----|-----------|------|--------|-------|--------|--------|
| A | Planeación/calidad/seguridad | plugin | superpowers | global | <repo> | instalado / pendiente |
| A | Estándares de ingeniería | skill | engineering-standards | global | <repo> | … |
| A | Seguridad | skill | security-guidance (+ comando /security-review) | global | <repo> | … |
| B | Diseño | — | *(set de diseño — configurable)* | global | a confirmar | pendiente |
| C | Tecnología | skill | <según stack> | global | a confirmar | … |
| D | Dominio | skill | <tópico> | local | repo | … |
| E | Autoría propia | skill | <skill de producto> | local | repo | creada / pendiente |

## Detalle

### A · Planeación, calidad y seguridad (global)
- …

### B · Diseño (global)
- *(Set de diseño del usuario — pendiente de configurar; ver `taxonomy.md`.)*

### C · Tecnologías (global)
- Stack detectado: `<lista>`
- …

### D · Tópico / dominio (local)
- …

### E · Autoría propia (local)
- Creadas: …
- **Pendientes** (decisión no tomada aún): …

## MCPs
| MCP | Nivel | Declarado en | Estado |
|-----|-------|--------------|--------|
| <db> | local | `.mcp.json` | … |
| <github/búsqueda> | global | `claude mcp -s user` | … |

## Pendientes / a confirmar
- [ ] Orígenes marcados "a confirmar" (resolver con `npx skills find`).
- [ ] Skills de categoría E cuya decisión de producto sigue abierta.

## Cómo se reproduce este tooling
- **Global:** seguir la sección **Setup** del `README.md`.
- **Local:** ya está en el repo (`.claude/skills/`, `.claude/settings.json`, `.mcp.json`);
  se activa al abrir el proyecto en Claude Code.
