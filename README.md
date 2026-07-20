# controle-de-projetos

Dashboard de acompanhamento dos projetos de automação/BI da Luxor
(Planejamento & Controle). App HTML único, tema Luxor.

> ⚠ **Repositório PÚBLICO.** Nenhum dado de projeto vive aqui — só a casca do app.
> Os dados reais ficam no Supabase, atrás de autenticação + RLS. Nunca commitar
> `projetos.json`, backups, service_role key ou qualquer conteúdo real.

## Arquitetura (site compartilhado)

- **Front**: este HTML, hospedado no **Netlify** (deploy do repo).
- **Dados**: **Supabase** (Postgres). Tabela `app_state`, 1 linha (`id='projetos'`,
  `data jsonb`) = a lista viva compartilhada. Realtime → todos veem edição na hora.
- **Auth**: Supabase (magic-link por e-mail), restrito ao domínio `@luxor.com.br`
  via política RLS. Sem login válido, o app não carrega dado.
- **Config**: `config.js` (versionado) com `SUPABASE_URL` + anon key.
  A anon key é pública por design (RLS é quem protege), então pode ficar no repo.

## Dados / segurança

- Anon key: pode ficar no front (pública). service_role: **jamais**.
- RLS obrigatória: sem política, a anon key exporia a tabela. Ver `supabase_schema.sql`.
- Regra herdada do app: load = leitura/merge, nunca sobrescreve cegamente;
  `STORAGE_KEY` do localStorage vira só cache offline. Ver `README_DADOS.md`.

## Setup

1. Criar projeto no Supabase, rodar `supabase_schema.sql` no SQL editor.
2. Habilitar Realtime na tabela `app_state` e auth por e-mail (magic link).
3. Semear o dado real (script fora do repo).
4. Netlify conecta o repo (deploy automático, sem build, publish dir = raiz).
5. Supabase → Authentication → URL Configuration → Site URL = URL do Netlify.
