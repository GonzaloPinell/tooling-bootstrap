# Banco de preguntas para refinar REQUIREMENTS.md

Catálogo de preguntas por tema para la skill `requirements-refiner`. **No las hagas
todas**: elige las que cierren vacíos reales, en rondas de 3–4 (vía `AskUserQuestion`),
priorizando lo que más afecta a arquitectura y tooling. Acompaña cada pregunta de
opciones concretas y una recomendada cuando puedas inferirla.

> Los 14 temas reflejan las 14 secciones canónicas de `REQUIREMENTS.template.md`.
> Prioridad de impacto en el tooling: **Stack > Datos/Integraciones > Seguridad/Escala >
> Plataformas/Despliegue > Diseño > Calidad > Roadmap/Restricciones.** Empieza por
> producto/dominio y objetivos para anclar el resto.

## 1. Producto y dominio
- ¿Cuál es el problema central y por qué ahora?
- ¿En qué dominio/industria opera? (afecta a la skill de tópico, cat. D)
- ¿Qué lo diferencia de alternativas existentes?
- ¿Hay regulación o jerga del dominio que el agente deba conocer?

## 2. Objetivos y métricas de éxito
- ¿Cuáles son los 3–5 objetivos principales del producto?
- ¿Cómo se mide el éxito? (KPI, métrica, umbral concreto)
- ¿Qué métrica de negocio mueve el producto? (ingresos, retención, conversión, adopción…)
- ¿Hay un objetivo cuantitativo a 3–6 meses que defina "éxito"?

## 3. Usuarios y casos de uso
- ¿Quiénes son los usuarios/roles? ¿Internos o externos?
- ¿Cuáles son los 3 flujos más importantes de principio a fin?
- ¿Hay usuarios con permisos diferenciados (admin vs usuario)?

## 4. Alcance y NO-objetivos
- ¿Qué entra en el **MVP** y qué queda explícitamente fuera?
- ¿Qué tecnologías o enfoques quieres **excluir**? (p. ej. "no Next.js")
- ¿Hay un "anti-objetivo" claro (lo que el producto NO debe volverse)?

## 5. Stack y arquitectura
- ¿Lenguaje(s) principal(es) ya decidido(s) o abierto(s)?
- ¿Framework de frontend? (React/Vue/Svelte/Angular/ninguno)
- ¿Backend? (Node/Python/Go/Rust/…); ¿estilo? (monolito/microservicios/serverless)
- ¿Monorepo o repos separados? ¿Gestor de paquetes?
- ¿Hay decisiones de arquitectura ya cerradas que deba respetar?

## 6. Datos y persistencia
- ¿Qué entidades/datos centrales maneja?
- ¿Tipo de almacenamiento? (relacional/NoSQL/ficheros/caché/búsqueda)
- ¿Volumen y crecimiento esperado de datos?
- ¿Necesita migraciones, versionado de esquema, o un MCP de la DB?

## 7. Integraciones y APIs
- ¿Servicios de terceros? (pagos, auth, email/SMS, IA/LLM, mapas, analítica)
- ¿Consume APIs externas, expone una API propia, o ambas? (REST/GraphQL/gRPC)
- ¿Webhooks o eventos entrantes/salientes?

## 8. Seguridad, privacidad y cumplimiento
- ¿Maneja PII o datos sensibles? ¿Cuáles?
- ¿Requisitos de cumplimiento? (GDPR, PCI-DSS, HIPAA, SOC2…)
- ¿Cómo se autentican y autorizan los usuarios? (OAuth, JWT, SSO, roles)
- ¿Secretos/credenciales: cómo se gestionan?

## 9. Rendimiento y escala
- ¿Carga esperada? (usuarios concurrentes, RPS, tamaño de dataset)
- ¿Requisitos de latencia o de **tiempo real**? (websockets, streaming)
- ¿Picos estacionales o crecimiento agresivo?

## 10. Plataformas y despliegue
- ¿Plataformas objetivo? (web, móvil iOS/Android, escritorio, CLI, API)
- ¿Dónde se despliega? (nube concreta, on-prem, edge, contenedores)
- ¿CI/CD deseado? ¿Entornos (dev/stage/prod)?

## 11. Diseño y UX
- ¿Hay sistema de diseño/branding existente o se parte de cero?
- ¿Nivel de exigencia de UI? (interno funcional vs producto pulido)
- ¿Accesibilidad (WCAG) e internacionalización (i18n) en alcance?

## 12. Calidad, testing y observabilidad
- ¿Estrategia de pruebas? (unit/integración/E2E, cobertura objetivo)
- ¿Logging, métricas, trazas, alertas?
- ¿Definición de "hecho" / criterios de aceptación?

## 13. Restricciones (equipo, tiempo, presupuesto)
- ¿Tamaño y experiencia del equipo? (afecta a la complejidad recomendable)
- ¿Plazos o hitos duros?
- ¿Restricciones de presupuesto, licencias o proveedores?

## 14. Roadmap y fases
- ¿Cuál es la fase 1 mínima viable?
- ¿Qué viene después y qué puede esperar?
- ¿Qué hito haría declarar el proyecto un éxito a 3–6 meses?

---

### Cómo formular cada ronda
1. Agrupa por tema y empieza por el de mayor impacto pendiente.
2. Da **opciones concretas** (con una "Recomendada" cuando la inferencia lo permita).
3. Permite respuestas libres ("Other") para lo no anticipado.
4. Si una decisión no está tomada, ofrécela como **"Decidir más tarde"** → va a
   "Decisiones pendientes", no se fuerza.
