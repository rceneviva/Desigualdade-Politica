# filename: scripts/boots/README.md
# Bootstrap da árvore mínima de diretórios

Este diretório contém scripts de **bootstrap** para criar a estrutura mínima de pastas do repositório e os arquivos `.gitkeep` necessários para versionar pastas vazias.

## O que os scripts fazem
- Criam as seguintes pastas (se ainda não existirem):
  - `data/raw`, `data/interim`, `data/processed`, `data/external`
  - `docs`, `logs`, `metadata`
  - `config/schema`, `config/logging`
  - `src/ingest`, `src/qa`, `src/utils`
- Adicionam um arquivo vazio `.gitkeep` dentro de cada pasta.
- **Não** sobrescrevem conteúdo existente (execução idempotente).
- Imprimem uma dica de configuração para o `.gitignore` (não alteram arquivos automaticamente).

## Uso
### Linux/macOS (bash)
```bash
chmod +x scripts/boots/boots.sh
./scripts/boots/boots.sh
