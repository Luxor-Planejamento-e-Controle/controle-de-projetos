-- Schema do Controle de Projetos (Supabase / Postgres).
-- DDL apenas — nenhum dado real. Rodar no SQL editor do Supabase.

-- 1) Tabela: 1 linha por "documento". O dashboard usa id = 'projetos'.
create table if not exists app_state (
  id          text primary key,
  data        jsonb not null default '[]'::jsonb,
  updated_at  timestamptz not null default now()
);

-- 2) RLS ligada. Sem política, a anon key NÃO acessa nada.
alter table app_state enable row level security;

-- 3) Só e-mails @luxor.com.br autenticados leem/gravam.
drop policy if exists "luxor_select" on app_state;
create policy "luxor_select" on app_state
  for select to authenticated
  using ( (auth.jwt() ->> 'email') like '%@luxor.com.br' );

drop policy if exists "luxor_update" on app_state;
create policy "luxor_update" on app_state
  for update to authenticated
  using      ( (auth.jwt() ->> 'email') like '%@luxor.com.br' )
  with check ( (auth.jwt() ->> 'email') like '%@luxor.com.br' );

-- 4) Linha única do dashboard (vazia; o seed real é aplicado à parte, fora do repo).
insert into app_state (id, data) values ('projetos', '[]'::jsonb)
  on conflict (id) do nothing;

-- 5) Realtime: publica a tabela para receber mudanças ao vivo.
alter publication supabase_realtime add table app_state;
