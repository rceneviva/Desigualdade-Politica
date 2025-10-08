# Desigualdade-Politica
Repositório Público de dados, códigos, protocolos de pesquisa e arquivos do projeto Desigualdade Política no Brasil

# filename: README.md
# Desigualdade Política no Brasil: participação eleitoral (1988–2025)
Governança técnico-metodológica do repositório para padronização e reprodutibilidade.

## Finalidade e escopo
Este repositório documenta arquitetura, padrões e normas para organizar dados e código relativos à participação eleitoral no Brasil entre 1988 e 2025. Não há coleta, processamento ou download nesta etapa. Define-se a infraestrutura mínima para, nas etapas seguintes, executar ingestão, harmonização e QA de dados.

## Estrutura de diretórios
Árvore sugerida. Comentários entre parênteses indicam finalidade.

├── data
│   ├── raw/          (artefatos originais; somente leitura)
│   ├── interim/      (dados normalizados: encoding e nomes)
│   ├── processed/    (bases consolidadas: UF/município)
│   └── external/     (tabelas auxiliares; ex.: crosswalk TSE↔IBGE)
├── docs/             (relatórios, specs, codebooks)
├── logs/             (eventos em JSON Lines; rotação por tamanho/data)
├── metadata/         (manifestos, hashes, proveniência)
├── config
│   ├── schema/       (schema de colunas e tipos por período)
│   └── logging/      (configuração de logging; ex.: YAML)
└── src
├── ingest/       (scripts de ingestão – etapa futura)
├── qa/           (testes de validação – etapa futura)
└── utils/        (utilitários comuns – etapa futura)


## Padrões de formato (obrigatórios)
CSV com vírgula como separador de campo; ponto “.” como separador decimal; encoding UTF-8 sem BOM; NA para ausentes; fim de linha LF; datas ISO 8601 (YYYY-MM-DD); nomes de colunas em `snake_case` e sem acentos. Timezone padrão: UTC. Locale: `pt_BR` para textos.

## Convenções de nomenclatura
Arquivos de dados:  
`participacao_{nivel}_{ano}_{turno}_{cargo}_v{semver}.csv`

Onde:  
`nivel ∈ {uf, municipio}`; `turno ∈ {t1, t2}`;  
`cargo ∈ {PR, GOV, SEN, DF, DE, PREF, VERE}`.

Exemplos:
- `participacao_uf_2002_t1_PR_v1.0.0.csv`
- `participacao_municipio_2016_t2_PREF_v1.2.3.csv`

Datasets, codebooks e scripts seguem `snake_case` com prefixo do escopo. Exemplos: `schema_participacao.yml`, `codebook_participacao.md`.

## Versionamento (semver duplo)
Adota-se versionamento independente para **código** e **dados**.

- **Código (licença Apache-2.0)**  
  `major` para quebras de API; `minor` para novas funcionalidades compatíveis; `patch` para correções.  
  Tag: `code-vX.Y.Z` (ex.: `code-v0.1.0`).

- **Dados (licença recomendada CC BY 4.0; metadados técnicos CC0 1.0)**  
  `major` quando houver alteração de schema/chaves;  
  `minor` quando houver acréscimo de linhas/anos sem quebrar schema;  
  `patch` para correções pontuais de valores.  
  Tag: `data-vX.Y.Z` (ex.: `data-v0.1.0`).

Manter `CHANGELOG.md` com entradas separadas para código e dados.

## Estratégia de branches (trunk-based em GitHub público protegido)
- Branch `main` protegida: merges **apenas via Pull Request** aprovado; status checks obrigatórios; impedir commits diretos.
- Branches curtos por escopo: `feat/<escopo>`, `fix/<escopo>`, `data/<escopo>`, `docs/<escopo>`.
- Recomendado: `CODEOWNERS` para revisão obrigatória; template de PR com checklist de QA.
- Integração contínua: definir workflows de lint/format/tipos e validação de schema (próxima etapa).

## Esquema de logs
Formato: **JSON Lines** (um evento por linha). Níveis: `INFO`, `WARNING`, `ERROR`. Rotacionar por tamanho/data.  
Campos mínimos por evento:
- `timestamp_utc`, `run_id`, `etapa`, `recurso`
- `fonte_url`, `arquivo_local`, `sha256`
- `n_linhas_lidas`, `n_linhas_escritas`, `n_descartadas`
- `encoding_detectado`, `separador_detectado`
- `avisos`, `erros`
- `versao_dados`, `versao_codigo`
- `duracao_ms`

Detalhamento avançado poderá constar em `LOGGING.md` (a ser criado na próxima etapa).

## Política de licenças e citação
- **Código:** Apache-2.0 (obrigatório).  
- **Dados/documentação derivados:** recomendar **CC BY 4.0** com atribuição explícita às fontes primárias (TSE – Portal de Dados Abertos; CEPESP/FGV – chaves e metadados quando aplicável).  
- **Metadados técnicos (ex.: manifestos, hashes):** recomendação **CC0 1.0**.

Publicar `CITATION.cff` na raiz para facilitar citação do repositório. Incluir referências às fontes primárias (URLs oficiais) e às versões `code-v*` e `data-v*`.

## Matriz RACI (curta)
- **Responsible (R):** mantenedor(es) do repositório por módulo (`src/ingest`, `src/qa`, `config/*`).  
- **Accountable (A):** mantenedor principal do projeto.  
- **Consulted (C):** revisor(es) metodológicos e especialistas em dados eleitorais.  
- **Informed (I):** contribuidores e usuários finais.

## Definition of Done (etapas futuras)
- **Coleta/ingestão:** manifestos em `metadata/` completos; logs sem erros; validação de integridade (hash/linhas).  
- **Harmonização:** conformidade com `config/schema/`; chaves e dicionários aplicados; idempotência verificada.  
- **QA:** testes em `src/qa/` aprovados; encoding e separadores verificados; amostras auditadas; `CHANGELOG.md` atualizado; tags `code-v*` e/ou `data-v*` criadas.

## Contribuição e governança
Consulte `CONTRIBUTING.md` para fluxo de trabalho, estilo de commit, versionamento e checklist de QA. Nesta etapa, não executar scripts nem instruções de coleta.
  


