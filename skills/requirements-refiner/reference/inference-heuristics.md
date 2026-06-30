# Heurísticas de inferencia

Reglas para deducir lo **implícito** de un `REQUIREMENTS.md` a partir de lo declarado.
Toda inferencia se presenta con su **base** y se etiqueta `(inferido — confirmar)`;
nunca como hecho cerrado. Sirve para **anticipar preguntas**, no para rellenar a ciegas.

## Meta-reglas
1. **Base explícita.** "Porque mencionas X ⇒ probablemente Y".
2. **Confirmable.** Toda inferencia relevante se convierte en pregunta de confirmación.
3. **Conservadora.** Ante duda entre varias opciones, ofrécelas; no elijas en silencio.
4. **Sin invención de hechos.** No infieras proveedores/versiones concretas que el
   usuario no insinuó; infiere la *necesidad*, pregunta la *opción*.

## Tabla de inferencias

| Señal en el borrador | Inferencia (confirmar) | Pregunta a disparar |
|----------------------|------------------------|---------------------|
| "app web" sin framework | Necesita framework frontend + build | ¿React/Vue/Svelte/Angular/ninguno? |
| "SEO" / "landing" / "contenido público" | Renderizado servidor (SSR/SSG) | ¿SSR/SSG (Next/Nuxt/Astro) o SPA? |
| "app móvil" | Stack móvil | ¿React Native / Flutter / nativo? |
| "escritorio" / "multiplataforma offline" | Empaquetado desktop | ¿Electron / Tauri / nativo? |
| "tiempo real" / "chat" / "colaborativo" | WebSockets / streaming | ¿Realtime (WS/SSE)? ¿qué latencia? |
| "pagos" / "checkout" / "suscripciones" | Pasarela + PCI + seguridad | ¿Stripe/otro? ¿guardáis tarjetas? (PCI) |
| "login" / "cuentas" / "usuarios" | AuthN/AuthZ + sesión + PII | ¿OAuth/JWT/SSO? ¿roles? |
| "datos personales" / "perfil" / "salud" | PII ⇒ privacidad/cumplimiento | ¿GDPR/HIPAA? ¿cifrado en reposo? |
| "dashboard" / "reportes" / "analítica" | Consultas agregadas + BD analítica | ¿volumen? ¿BI/MCP de DB? |
| "IA" / "LLM" / "chatbot" / "recomendaciones" | Integración con modelo + costos/tokens | ¿qué proveedor de modelo? ¿RAG? |
| "scraping" / "crawler" / "extracción web" | Automación de navegador + ética/legal + rate limits | ¿MCP de browser? ¿robots.txt/ToS? |
| "búsqueda" / "filtros avanzados" | Índice de búsqueda | ¿full-text en DB o motor (Elastic/Meili)? |
| "subida de archivos" / "imágenes" / "media" | Almacenamiento de objetos + límites | ¿S3/equivalente? ¿tamaños? |
| "notificaciones" / "emails" | Mensajería transaccional | ¿email/SMS/push? ¿proveedor? |
| "multi-idioma" / "global" | i18n/l10n | ¿qué idiomas? ¿formato de fechas/moneda? |
| "alto tráfico" / "viral" / "millones" | Escala + caché + colas | ¿RPS objetivo? ¿caché/queue? |
| "tiempo de carga" / "rápido" | Presupuesto de rendimiento | ¿métricas objetivo (LCP, p95)? |
| "equipo pequeño" / "solo yo" / "rápido" | Favorecer simplicidad (KISS/YAGNI) | ¿monolito simple sobre microservicios? |
| "empresa" / "B2B" / "clientes grandes" | SSO + auditoría + SLAs | ¿SOC2? ¿logs de auditoría? |
| menciona stack pero **excluye** algo ("no Next") | Exclusión dura | Respetar; **no** proponer lo excluido |
| "tests" / "calidad" / "CI" | Suite de pruebas + pipeline | ¿unit/integ/E2E? ¿GitHub Actions? |
| "móvil" + "web" + "API" | Backend compartido / monorepo | ¿monorepo? ¿API REST/GraphQL? |
| "offline" / "sin conexión" / "instalable" (web) | PWA: service workers / local-first / sync | ¿PWA? ¿almacenamiento local + sincronización? |
| "tareas programadas" / "cron" / "procesos en background" | Jobs/colas/scheduler | ¿qué jobs? ¿cron / worker / cola? |
| "blog" / "CMS" / "gestión de contenido" | CMS headless o a medida | ¿headless CMS (cuál) o propio? |
| "IA"/"LLM" con foco en calidad o coste | Evaluaciones (evals) + presupuesto de tokens | ¿cómo medís la calidad del modelo (evals)? ¿límite de coste? |
| "SaaS" / "multi-tenant" / "workspaces" / "por cliente" | Aislamiento de tenants + RBAC por tenant + billing por plan | ¿modelo de tenancy (fila / esquema / DB por tenant)? ¿facturación por suscripción? |
| "librería" / "SDK" / "paquete" (npm/pip/crate) | Publicación + semver + API pública estable + docs | ¿registro de publicación? ¿política de versionado? — **suprime** inferencia de framework frontend |
| "CLI" / "herramienta de línea de comandos" | Parsing de args + distribución (brew/npm/uv) | ¿cómo se distribuye el binario? — **suprime** inferencia de framework frontend |

## Inferencias hacia el tooling (puente con `tooling-bootstrap`)
- Stack inferido y **confirmado** ⇒ candidatos de categoría **C** (ver `stack-map.md`).
- Dominio claro ⇒ skill de tópico (cat. **D**) o, si no hay pública, autoría **E**.
- Reglas de negocio/decisiones de producto explícitas ⇒ candidatas a skills **E**.
- Datos propios/DB ⇒ posible **MCP local** en `.mcp.json`.
- Necesidades de diseño ⇒ categoría **B** (set de diseño configurable).

> Recuerda: aquí solo **infieres y preguntas**. La instalación la decide y ejecuta
> `/bootstrap` tras tu confirmación.
