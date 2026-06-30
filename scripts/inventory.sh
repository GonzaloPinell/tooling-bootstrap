#!/usr/bin/env bash
# inventory.sh — Inventario NO destructivo del tooling de Claude Code.
# Solo LEE y reporta. No instala, no modifica, no borra nada.
# Uso: bash scripts/inventory.sh   (ejecútalo desde la raíz del proyecto)

set -uo pipefail

section() { printf '\n=== %s ===\n' "$1"; }
have()    { command -v "$1" >/dev/null 2>&1; }

printf 'Inventario de tooling (solo lectura) — %s\n' "$(date '+%Y-%m-%d %H:%M')"
printf 'Proyecto: %s\n' "${CLAUDE_PROJECT_DIR:-$(pwd)}"

section "Plugins instalados (claude plugin list)"
if have claude; then
  claude plugin list 2>/dev/null || echo "  (no se pudo listar plugins)"
else
  echo "  claude CLI no encontrado en PATH"
fi

section "MCPs disponibles (claude mcp list)"
if have claude; then
  claude mcp list 2>/dev/null || echo "  (no se pudo listar MCPs)"
else
  echo "  claude CLI no encontrado en PATH"
fi

section "Skills globales (~/.claude/skills)"
if [ -d "$HOME/.claude/skills" ]; then
  ls -1 "$HOME/.claude/skills" 2>/dev/null || echo "  (vacío)"
else
  echo "  (no existe ~/.claude/skills)"
fi

section "Skills locales (.claude/skills)"
if [ -d ".claude/skills" ]; then
  ls -1 ".claude/skills" 2>/dev/null || echo "  (vacío)"
else
  echo "  (no existe .claude/skills en este repo)"
fi

section "Config local del proyecto"
for f in ".claude/settings.json" ".mcp.json"; do
  if [ -f "$f" ]; then
    echo "  presente: $f"
  else
    echo "  ausente:  $f"
  fi
done
# settings.local.json NO se inventaría como fuente de config portable (gitignored).
if [ -f ".claude/settings.local.json" ]; then
  echo "  nota: existe .claude/settings.local.json (NO portable; no usar para config de proyecto)"
fi

section "Manifiestos de stack detectados"
for f in package.json tsconfig.json pyproject.toml requirements.txt Cargo.toml \
         go.mod pubspec.yaml composer.json Gemfile Dockerfile compose.yaml \
         docker-compose.yml; do
  [ -f "$f" ] && echo "  presente: $f"
done

printf '\nFin del inventario. (No se modificó nada.)\n'
