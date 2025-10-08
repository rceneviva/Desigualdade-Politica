# filename: scripts/boots/boots.sh
#!/usr/bin/env bash
# Bootstrap de estrutura mínima de diretórios para o projeto
# - Cria a árvore de pastas padronizada
# - Garante a presença de arquivos .gitkeep para versionamento de pastas vazias
# - Não sobrescreve conteúdos existentes
# Uso: executar a partir da RAIZ do repositório:  ./scripts/boots/boots.sh

set -euo pipefail

# 1) Verificação de contexto (raiz do repositório)
if git rev-parse --show-toplevel >/dev/null 2>&1; then
  REPO_ROOT="$(git rev-parse --show-toplevel)"
else
  REPO_ROOT="$(pwd)"
fi

cd "$REPO_ROOT"

if [ ! -d ".git" ]; then
  echo "⚠️  Esta pasta não parece ser a raiz de um repositório git (.git ausente)."
  echo "    Prossiga apenas se tiver certeza. Diretório atual: $REPO_ROOT"
fi

echo "🔧 Criando árvore mínima de diretórios em: $REPO_ROOT"

# 2) Lista de diretórios a criar
DIRS=(
  "data/raw"
  "data/interim"
  "data/processed"
  "data/external"
  "docs"
  "logs"
  "metadata"
  "config/schema"
  "config/logging"
  "src/ingest"
  "src/qa"
  "src/utils"
)

# 3) Criação idempotente das pastas e .gitkeep
for d in "${DIRS[@]}"; do
  if [ ! -d "$d" ]; then
    mkdir -p "$d"
    echo "  📁 Criado: $d"
  else
    echo "  ✔️  Já existe: $d"
  fi

  if [ ! -f "$d/.gitkeep" ]; then
    : > "$d/.gitkeep"   # cria arquivo vazio de forma segura
    echo "     └─ ➕ .gitkeep"
  else
    echo "     └─ ✔️  .gitkeep"
  fi
done

# 4) Dicas para .gitignore (não altera automaticamente)
echo
echo "ℹ️  Dica para .gitignore (adicione se fizer sentido ao seu projeto):"
cat <<'EOT'
/data/*
!/data/**/.gitkeep
/logs/*
!/logs/**/.gitkeep
EOT

echo
echo "✅ Concluído. Revise alterações com: git status"
