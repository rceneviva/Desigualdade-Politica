# filename: CONTRIBUTING.md
# Guia de contribuição

Obrigado por contribuir. Este documento descreve o fluxo trunk-based, padrões de código/dados, estilo de commits, versionamento e QA. Nesta etapa, **não** execute coleta nem processamento.

## Fluxo trunk-based
- A branch `main` é **protegida**. Merges somente via Pull Request (PR) aprovado.
- Trabalhe em branches curtos:
  - `feat/<escopo>` novas funcionalidades de código;
  - `fix/<escopo>` correções;
  - `data/<escopo>` ajustes e versões de dados;
  - `docs/<escopo>` documentação.
- Abra PR pequeno, contextualizado e com escopo único. Vincule a issue correspondente.
- Checks obrigatórios no PR (definidos na próxima etapa): format (black), lint (ruff), tipos (mypy), validação de schema, verificação de logs.

## Estilo de commit
Mensagens curtas, no imperativo, com escopo e referência a issues. Recomenda-se o padrão:

():

Tipos aceitos: `feat`, `fix`, `refactor`, `docs`, `test`, `data`, `chore`.  
Exemplos:
- `feat(ingest): adicionar parser para schema 1994–2002`
- `data(participacao): corrigir NA em 2000_t1_PR`
- `docs(readme): esclarecer convenções de nomenclatura`
- `fix(utils): normalizar separador decimal em CSV`

## Padrões de código e dados (especificação)
- **Linguagem:** Python 3.11.
- **Formatação:** `black`.
- **Lint:** `ruff`.
- **Tipos:** `mypy` (modo estrito para `src/utils`, gradual nos demais).
- **Padrões de dados:** CSV com vírgula; decimal `.`; UTF-8 sem BOM; LF; `NA` para ausentes; datas ISO 8601; colunas `snake_case` sem acentos; timezone UTC; locale `pt_BR`.

A configuração de ferramentas e pre-commit será versionada na próxima etapa.

## Versionamento (semver)
Semver duplo com tags separadas.

**Código** (`code-vX.Y.Z`):
- `major`: quebra de API ou de CLIs.
- `minor`: novas funcionalidades compatíveis.
- `patch`: correções sem mudanças de API.

**Dados** (`data-vX.Y.Z`):
- `major`: mudança de schema/chaves ou redefinição de universo.
- `minor`: acréscimo de linhas/anos mantendo schema.
- `patch`: correções pontuais.

Atualize `CHANGELOG.md` e incremente versões conforme o impacto. Crie as tags correspondentes ao aprovar o PR.

## Documentação
Mantenha atualizados:
- `README.md` (arquitetura, padrões, logs, versionamento);
- `CITATION.cff` (metadados e referência preferida);
- `LOGGING.md` e `docs/` (especificações detalhadas) — a serem introduzidos na próxima etapa.

## QA: checklist mínimo antes de abrir PR
- [ ] Estrutura de diretórios respeitada.
- [ ] Arquivos CSV com separador vírgula, decimal `.`, LF, UTF-8 sem BOM, `NA` para ausentes.
- [ ] Colunas em `snake_case` e sem acentos.
- [ ] Conformidade com `config/schema/` (tipos e chaves).
- [ ] Logs em JSON Lines com campos mínimos preenchidos.
- [ ] `CHANGELOG.md` atualizado e versões ajustadas (`code-v*`/`data-v*`).
- [ ] Nenhum segredo/credencial incluído (verifique `.env`, history e diffs).
- [ ] PR pequeno e com escopo único; issue referenciada.

## Governança e revisão
- `CODEOWNERS` definirá revisores obrigatórios por área.
- Aprovam PRs: mantenedor responsável (R) e revisor metodológico (C). Em mudanças de schema, exigir anuência do responsável por dados (A).

## Boas práticas adicionais
- Commits atômicos; PRs ≤ ~300 linhas quando possível.
- Idempotência: reexecutar pipelines deve produzir os mesmos artefatos e logs.
- Observabilidade: cada etapa registra `run_id` e hashes em `metadata/`.
