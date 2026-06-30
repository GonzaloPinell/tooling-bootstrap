---
name: requirements-refiner
description: Convierte un REQUIREMENTS.md pobre, vago o incompleto en un documento sólido mediante una ronda exhaustiva de preguntas (AskUserQuestion) e inferencia explícita de lo implícito. Respalda el original, separa lo declarado de lo inferido, y reescribe el documento estructurado. Úsala cuando un REQUIREMENTS.md/foundation.md sea insuficiente, antes de /bootstrap, o cuando el usuario pida refinar/clarificar requerimientos.
---

# requirements-refiner — Eleva el cimiento del proyecto

El `REQUIREMENTS.md` es la base de todo el tooling y del trabajo del agente. Los
borradores reales suelen venir **vagos, parciales o con supuestos implícitos**. Esta
skill los transforma en un documento **completo, estructurado y explícito**, sin
perder información ni inventar hechos.

## Principios

1. **No destructivo.** Antes de tocar el borrador, crea un respaldo
   `REQUIREMENTS.backup-<fecha>.md`. Nunca pierdas contenido original.
2. **Declarado ≠ inferido.** Todo lo que deduzcas se etiqueta `(inferido — confirmar)`
   hasta que el usuario lo confirme. Jamás presentes una inferencia como hecho.
3. **Exhaustivo pero humano.** Pregunta en **rondas temáticas** de 3–4 preguntas, no
   en un muro de 40. Prioriza los vacíos que más afectan al tooling y a la arquitectura.
4. **Honesto.** Lo que no se pueda determinar queda en **"Decisiones pendientes"**, no
   se rellena con supuestos disfrazados de hechos.

## Proceso

### 1. Localizar y respaldar
- Busca el borrador: argumento → `REQUIREMENTS.md` → `foundation.md`.
- Si existe, **respáldalo** (`cp REQUIREMENTS.md REQUIREMENTS.backup-AAAAMMDD-HHMM.md`).
- Si no existe (o `--from-scratch`), parte de
  `${CLAUDE_PLUGIN_ROOT}/skills/tooling-bootstrap/reference/REQUIREMENTS.template.md`.

### 2. Análisis de vacíos
Mapea el borrador contra las **secciones canónicas** y marca cada una `OK / Pobre / Falta`:

1. Visión y dominio · 2. Objetivos y métricas de éxito · 3. Usuarios y casos de uso ·
4. Alcance y **no-objetivos** · 5. Stack y arquitectura · 6. Datos y persistencia ·
7. Integraciones y APIs externas · 8. Seguridad, privacidad y cumplimiento ·
9. Rendimiento y escala · 10. Plataformas y despliegue · 11. Diseño y UX ·
12. Calidad, testing y observabilidad · 13. Restricciones (equipo, tiempo, presupuesto) ·
14. Roadmap y fases.

Presenta un breve mapa de cobertura (qué está, qué falta) antes de preguntar.

### 3. Inferencia explícita
A partir de lo declarado y de
`reference/inference-heuristics.md`, deduce lo implícito.
Por cada inferencia:
- Decláralo con su **base** ("porque mencionas pagos ⇒ …").
- Etiquétalo `(inferido — confirmar)`.
- Conviértelo en una pregunta de confirmación cuando sea relevante.

### 4. Preguntas exhaustivas (rondas)
Usa `AskUserQuestion` por temas, de mayor a menor impacto. Apóyate en
`reference/question-bank.md`. Pautas:
- 3–4 preguntas por ronda; varias rondas hasta cerrar los vacíos **críticos**.
- Ofrece opciones concretas y razonables (con una recomendada) + deja espacio a "Other".
- No repreguntes lo ya respondido ni lo claramente declarado en el borrador.
- Para decisiones que el usuario aún no ha tomado, captúralas como **pendientes**, no
  fuerces una respuesta.

Ancla siempre con **Producto/dominio + Objetivos** para fijar contexto; a partir de ahí
prioriza por **impacto en el tooling** (Stack > Datos/Integraciones > Seguridad/Escala > …),
como indica `reference/question-bank.md`. Secuencia de referencia (recorre las secciones
canónicas, saltando lo ya respondido): Producto/dominio → Objetivos/métricas → Usuarios/casos →
Alcance/no-objetivos → Stack/arquitectura → Datos → Integraciones → Seguridad →
Escala/rendimiento → Plataformas/despliegue → Diseño/UX → Calidad/testing →
Restricciones → Roadmap.

### 5. Síntesis (reescritura)
Reescribe `REQUIREMENTS.md` siguiendo la plantilla, integrando respuestas +
inferencias **confirmadas**. Requisitos de la salida:
- Estructura completa por secciones canónicas.
- Marca cada supuesto aún sin confirmar como `(inferido — confirmar)`.
- Sección final **"Decisiones pendientes"** con lo abierto y por qué importa.
- Conserva enlaces/datos del original que sigan vigentes.

### 6. Resumen y siguiente paso
Reporta: secciones completadas, qué se infirió, qué quedó pendiente, dónde está el
respaldo, y sugiere ejecutar **`/bootstrap`** para configurar el tooling sobre la base refinada.

## Anti-patrones (evítalos)
- ❌ Sobreescribir el borrador sin respaldo.
- ❌ Inventar stack/integraciones que el usuario no mencionó ni confirmó.
- ❌ Volcar 30 preguntas de una vez.
- ❌ Borrar contenido del original "porque parecía irrelevante".
- ❌ Cerrar el refinamiento con vacíos críticos sin marcarlos como pendientes.
