# tooling-bootstrap

Plugin de [Claude Code](https://claude.com/claude-code) que, con **un solo comando**,
deja un proyecto con el **tooling de agente** (Skills, Plugins, MCPs) correctamente
configurado a partir de su `REQUIREMENTS.md` — distinguiendo **qué va global** (nivel
usuario, reutilizable) de **qué va local** (versionado en el repo).

> **Principio rector:** este plugin **instala, declara, crea y documenta. Nunca
> desinstala ni borra.** La limpieza es siempre manual y queda fuera de su alcance.

## ¿Por qué?

Un buen flujo de trabajo con IA empieza por darle al agente el contexto y las
herramientas adecuadas. Hacerlo a mano en cada proyecto es lento e inconsistente.
`tooling-bootstrap` codifica una metodología repetible:

1. **Refina** primero el `REQUIREMENTS.md` (la base de todo) con una ronda exhaustiva
   de preguntas + inferencia de lo implícito.
2. **Infiere** el tooling necesario por categorías y lo propone para tu confirmación.
3. **Configura** lo global a nivel usuario y lo local en el repo, de forma **idempotente**.
4. **Documenta** todo en `TOOLING.md` y en la sección Setup del `README.md` para que
   sea **portable** a otras máquinas.

## Comandos

| Comando | Qué hace |
|---------|----------|
| `/refine-requirements` | Convierte un `REQUIREMENTS.md` pobre en uno sólido: preguntas exhaustivas + inferencia explícita, con respaldo del original. |
| `/bootstrap` | Flujo completo: gate de refinamiento → análisis → manifiesto (con confirmación) → inventario → instalar/declarar solo lo que falte → crear skills propias → generar `TOOLING.md` + Setup del README → resumen. |

## Filosofía en una imagen

- **Global vs Local:** *¿sirve igual en cualquier proyecto?* → global; *¿es propio de
  este producto?* → local.
- **5 categorías:** **A** planeación/calidad/seguridad · **B** diseño · **C**
  tecnologías · **D** dominio · **E** autoría propia.
- **3 tipos:** skill · plugin · mcp.
- **Portabilidad:** lo global se reinstala vía README; lo local viaja en git
  (`.claude/skills`, `.claude/settings.json`, `.mcp.json`). Nunca en `settings.local.json`.

Detalle completo en
[`skills/tooling-bootstrap/reference/taxonomy.md`](skills/tooling-bootstrap/reference/taxonomy.md).

## Estructura del plugin

```
tooling-bootstrap/
├── .claude-plugin/
│   ├── plugin.json                # manifiesto del plugin
│   └── marketplace.json           # este repo también es marketplace
├── commands/
│   ├── bootstrap.md               # /bootstrap
│   └── refine-requirements.md     # /refine-requirements
├── skills/
│   ├── tooling-bootstrap/
│   │   ├── SKILL.md               # filosofía + algoritmo (la "inteligencia")
│   │   └── reference/             # taxonomía, stack-map, plantillas, snippet README
│   └── requirements-refiner/
│       ├── SKILL.md               # metodología de refinamiento
│       └── reference/             # banco de preguntas + heurísticas de inferencia
├── agents/
│   └── stack-detector.md          # subagente de detección de stack (solo lectura)
└── scripts/
    └── inventory.sh               # inventario no destructivo
```

## Instalación

### Opción A — marketplace local (para desarrollo/prueba)
```bash
git clone https://github.com/gonzalopinell/tooling-bootstrap
claude plugin marketplace add ./tooling-bootstrap
claude plugin install tooling-bootstrap@gonzalo-marketplace
# Aplica los cambios: reinicia Claude Code (o usa el menú /plugin)
```

### Opción B — desde GitHub
```bash
claude plugin marketplace add gonzalopinell/tooling-bootstrap
claude plugin install tooling-bootstrap@gonzalo-marketplace
# Reinicia Claude Code (o usa el menú /plugin) para aplicar los cambios
```

### Actualizar
```bash
claude plugin marketplace update gonzalo-marketplace          # refresca el caché
claude plugin update tooling-bootstrap@gonzalo-marketplace    # usa el nombre CUALIFICADO
# Reinicia Claude Code para aplicar. (El update con el nombre simple "tooling-bootstrap"
# puede fallar con "Plugin not found"; usa siempre <plugin>@<marketplace>.)
```

> Nota CLI: `claude plugin install` instala con scope `user` por defecto y **no** acepta `-y`.

## Uso

```bash
# 1. Crea un REQUIREMENTS.md (o usa la plantilla del plugin) en tu proyecto.
# 2. (opcional) Refínalo:
/refine-requirements
# 3. Configura el tooling:
/bootstrap
```

- Sin `REQUIREMENTS.md`, `/bootstrap` se detiene y te explica cómo crearlo (no instala nada).
- Usa `/bootstrap --dry-run` para ver el plan sin ejecutar instalaciones.

## Desarrollo

```bash
claude plugin validate ./tooling-bootstrap      # valida manifiestos
claude plugin marketplace add ./tooling-bootstrap
claude plugin install tooling-bootstrap@gonzalo-marketplace
claude plugin details tooling-bootstrap         # componentes + coste en tokens
```

## Garantías

- **No destructivo** · **Idempotente** · **Portable** · **Honesto con orígenes**
  (lo que no se puede verificar se marca "a confirmar", no se inventa).

## Licencia

MIT (pendiente de añadir `LICENSE`).
