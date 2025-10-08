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
