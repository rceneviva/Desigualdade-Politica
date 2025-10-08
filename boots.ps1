# filename: scripts/boots/boots.ps1
<# 
Bootstrap de estrutura mínima de diretórios para o projeto (PowerShell)
- Cria a árvore de pastas padronizada
- Garante a presença de arquivos .gitkeep para versionamento de pastas vazias
- Não sobrescreve conteúdos existentes
Uso:
  1) Abrir PowerShell na RAIZ do repositório
  2) Executar: .\scripts\boots\boots.ps1
Dica: pode ser necessário permitir scripts locais:
  Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# 1) Verificação de contexto (raiz presumida é o diretório atual)
$RepoRoot = (Get-Location).Path
if (-not (Test-Path ".git")) {
  Write-Warning "Esta pasta não parece ser a raiz de um repositório git (.git ausente)."
  Write-Host   "Prossiga apenas se tiver certeza. Diretório atual: $RepoRoot"
}
Write-Host "🔧 Criando árvore mínima de diretórios em: $RepoRoot"

# 2) Lista de diretórios a criar
$dirs = @(
  "data/raw",
  "data/interim",
  "data/processed",
  "data/external",
  "docs",
  "logs",
  "metadata",
  "config/schema",
  "config/logging",
  "src/ingest",
  "src/qa",
  "src/utils"
)

# 3) Criação idempotente das pastas e .gitkeep
foreach ($d in $dirs) {
  if (-not (Test-Path $d -PathType Container)) {
    New-Item -ItemType Directory -Force -Path $d | Out-Null
    Write-Host "  📁 Criado: $d"
  } else {
    Write-Host "  ✔️  Já existe: $d"
  }

  $keep = Join-Path $d ".gitkeep"
  if (-not (Test-Path $keep -PathType Leaf)) {
    New-Item -ItemType File -Force -Path $keep | Out-Null
    Write-Host "     └─ ➕ .gitkeep"
  } else {
    Write-Host "     └─ ✔️  .gitkeep"
  }
}

# 4) Dicas para .gitignore (não altera automaticamente)
Write-Host ""
Write-Host "ℹ️  Dica para .gitignore (adicione se fizer sentido ao seu projeto):"
@"
/data/*
!/data/**/.gitkeep
/logs/*
!/logs/**/.gitkeep
"@
Write-Host ""
Write-Host "✅ Concluído. Revise alterações com: git status"
