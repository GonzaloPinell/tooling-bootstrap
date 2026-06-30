---
description: Refina un REQUIREMENTS.md pobre o incompleto con una ronda exhaustiva de preguntas + inferencia de lo implícito, y reescribe un documento sólido (NO destructivo).
argument-hint: "[ruta/a/REQUIREMENTS.md] [--from-scratch]"
allowed-tools: Bash, Read, Write, Edit, Glob, Grep, AskUserQuestion, Skill
---

# /refine-requirements — Convierte un borrador en un REQUIREMENTS.md sólido

El `REQUIREMENTS.md` es el cimiento de todo el bootstrap: si está pobre, el tooling
inferido será pobre. Tu trabajo es **elevar** ese documento mediante preguntas
exhaustivas e inferencia explícita de lo implícito, **sin perder** información ni
inventar hechos.

Argumentos: `$ARGUMENTS`
- Ruta opcional al borrador (por defecto: `REQUIREMENTS.md`, y si no, `foundation.md`).
- `--from-scratch` → no hay borrador; arranca desde la plantilla.

> Las rutas a archivos internos del plugin se referencian con `${CLAUDE_PLUGIN_ROOT}`
> porque al ejecutar este comando el directorio de trabajo es el **proyecto del usuario**.

## Procedimiento

Carga y sigue la skill **`requirements-refiner`**. En resumen:

1. **Localiza y respalda** el borrador. **Nunca** sobreescribas sin crear antes una
   copia `REQUIREMENTS.backup-AAAAMMDD-HHMM.md` (o `.bak`). Si no existe borrador,
   parte de `${CLAUDE_PLUGIN_ROOT}/skills/tooling-bootstrap/reference/REQUIREMENTS.template.md`.
2. **Análisis de vacíos**: clasifica cada sección canónica como `OK / Pobre / Falta`
   (visión/dominio, objetivos y métricas, usuarios y casos de uso, alcance/no-objetivos,
   stack y arquitectura, datos y persistencia, integraciones, seguridad y cumplimiento,
   rendimiento y escala, plataformas y despliegue, diseño/UX, calidad/testing,
   restricciones de equipo, roadmap).
3. **Inferencia**: deduce lo implícito a partir de lo declarado y de las heurísticas
   (`${CLAUDE_PLUGIN_ROOT}/skills/requirements-refiner/reference/inference-heuristics.md`).
   **Etiqueta cada inferencia** como `(inferido — confirmar)`. Nunca presentes una
   inferencia como hecho.
4. **Preguntas exhaustivas**: usa `AskUserQuestion` en **rondas temáticas y
   priorizadas** (3–4 preguntas por ronda, varias rondas), apoyándote en
   `${CLAUDE_PLUGIN_ROOT}/skills/requirements-refiner/reference/question-bank.md`.
   Sigue hasta cerrar los vacíos críticos; no abrumes con 40 preguntas de golpe.
5. **Síntesis**: reescribe `REQUIREMENTS.md` estructurado según la plantilla,
   integrando respuestas + inferencias confirmadas. Deja una sección
   **"Decisiones pendientes"** con lo que siga abierto.
6. **Resumen**: qué se añadió, qué se infirió, qué quedó pendiente, y siguiente paso
   sugerido (`/bootstrap`).

## Reglas
- **No destructivo**: respaldo previo obligatorio; nunca pierdas contenido original.
- **Separación clara**: distingue siempre *declarado por el usuario* de *inferido*.
- **Honesto**: si algo no se puede determinar, queda en "Decisiones pendientes", no
  se inventa.
