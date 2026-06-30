# Taxonomía: categorías, tipos y nivel (global/local)

Referencia que usa la skill `tooling-bootstrap` para clasificar y decidir cada
herramienta. **Nada aquí instala o borra**: es criterio de decisión.

## Decisión global vs local

```
¿La herramienta sirve igual en CUALQUIER proyecto?
├── Sí  → GLOBAL (nivel usuario). Se instala una vez y se documenta en el README.
└── No  → ¿Es conocimiento de dominio reutilizable con una skill pública sólida?
          ├── Sí → GLOBAL (cat. C/D): conocimiento de área reutilizable, no propio del producto.
          └── No → ¿Codifica una decisión/convención propia de ESTE producto?
                    ├── Sí → LOCAL (cat. D/E; se versiona en el repo).
                    └── No → reevalúa; probablemente Global.
```

- **Global** → `claude plugin install <plugin>@<marketplace>` (scope `user` por
  defecto), `npx skills add` (a `~/.claude/skills`), `claude mcp add -s user`,
  CLIs (`brew`/`uv`). Documentado en README (sección Setup).
- **Local** → `.claude/settings.json` (`extraKnownMarketplaces` + `enabledPlugins`),
  `.claude/skills/<nombre>/`, `.mcp.json`. **Versionado en git.**
- **Nunca** uses `settings.local.json` para config de proyecto (está gitignored y no viaja).

## Los 3 tipos

| Tipo | Qué es | Dónde vive (global / local) |
|------|--------|------------------------------|
| **Skill** | Conocimiento/procedimiento activado por descripción | `~/.claude/skills/` / `.claude/skills/` |
| **Plugin** | Paquete (commands+skills+agents+hooks+mcp) vía marketplace | install `-y` (nivel usuario por defecto) / `enabledPlugins` en `.claude/settings.json` |
| **MCP** | Servidor de herramientas/datos externos | `claude mcp add -s user` / `.mcp.json` |

## Las 5 categorías

### A · Planeación, calidad y seguridad — **Global**
Base metodológica de cualquier proyecto:
- **Metodología:** `superpowers` (writing-skills, brainstorming, planning), `spec-kit`
  (`specify`), `gh` (GitHub CLI).
- **Ciberseguridad:** skill/guía `security-guidance` + comando `/security-review`.
- **Estándares de ingeniería:** skill **`engineering-standards`** (Clean Architecture,
  SOLID, componentización, modularización, testing, DRY/YAGNI/KISS).

### B · Diseño — **Global** *(CONFIGURABLE — completar por el usuario)*
> El "set de diseño habitual del usuario". **Placeholder:** rellena esta sección con
> tus skills/plugins de diseño preferidos. Mientras esté vacío, el bootstrap **propone**
> la categoría pero **no instala** nada de diseño sin tu indicación.
>
> ```
> # Set de diseño de Gonzalo (rellenar)
> - skill/plugin:  <nombre>   origen: <repo o "a confirmar">   nivel: global
> - ...
> ```
> Candidatos comunes si decides poblarla: revisión de diseño/UX, design tokens,
> componentes accesibles, heurísticas de UI. Confírmalos con `npx skills find` antes de fijar origen.

### C · Tecnologías — **Global**
Según el stack detectado. Ver `stack-map.md` para el mapeo tecnología → candidatos.
Solo propón lo que el stack del proyecto realmente use; excluye lo que el
`REQUIREMENTS.md` rechace explícitamente.

### D · Tópico / dominio — **Local**
Conocimiento del área del producto (p. ej. "scraping ético", "facturación electrónica",
"motores de juego"). Si existe una skill pública sólida y reutilizable, puede ser
Global de tipo C/D; **si no hay una pública adecuada, créala como E (local)**.

### E · Autoría propia — **Local**
Skills que codifican **decisiones de ESTE producto** (convenciones de API, reglas de
negocio, glosario, flujos propios). Se crean con `skill-creator` +
`superpowers:writing-skills`, **solo cuando la decisión está tomada**. Si no, se
registran como **pendientes** en `TOOLING.md`.

## Reglas de origen
- Si conoces el repo/marketplace de una herramienta, regístralo.
- Si **no**, márcalo `origen: a confirmar` y resuélvelo con `npx skills find <término>`
  o `claude plugin marketplace …`. **No inventes** orígenes.
