# Controle de Projetos — como funciona

## Uso (simples)
- **Duplo-clique em `dashboard-projetos.html`** para abrir no navegador.
- Edite à vontade (status, prioridade, complexidade, novo/editar/excluir, arrastar).
- **Tudo salva sozinho** no navegador a cada mudança. Não precisa baixar nem clicar em salvar.

## Por que nada se perde
- Suas edições ficam gravadas automaticamente (localStorage), no mesmo PC/navegador.
- A cada gravação guarda um **backup de 1 passo** (desfaz acidente).
- O painel lembra o que foi **removido**: projeto que você excluiu **não volta**.

## Quando eu (Claude) adiciono um projeto novo
1. Você pede: "adiciona o projeto X, responsável Y".
2. Eu edito o arquivo (`dashboard-projetos.html` + `projetos.json`) partindo da **sua versão atual**.
3. Você dá **Ctrl+F5**. O projeto novo aparece; **suas classificações e remoções continuam intactas**.

Regra técnica: o app junta a sua lista salva (verdade) com **apenas os projetos novos** que eu marquei no arquivo — nunca reintroduz o que você tirou, nunca apaga o que você classificou.

## Arquivos
- `dashboard-projetos.html` — o painel (abra este).
- `projetos.json` — cópia da lista (backup / base para eu editar / versionar no git).
- `backup_projetos_recuperado.json` — snapshot de recuperação.
- `backups/` — snapshots antigos.

## Blindagem extra (opcional)
- Se quiser um ponto de recuperação no git: clique **Exportar JSON**, substitua `projetos.json` e commite. Fica imune até a limpeza de navegador.

## Nunca fazer
- Não limpar "dados de sites"/cache do navegador sem exportar antes (apaga as edições locais).
