%%%-------------------------------------------------------------------
%%% @author mauricio
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. out 2021 11:35
%%%-------------------------------------------------------------------
-module(teste).
-author("mauricio").
-mod_title("teste zotonic site").
-mod_description("A simple weblog, used as an example of how to create a Zotonic site.").
-mod_prio(10).
-export([manage_schema/2]).

-mod_schema(1).
-include_lib("zotonic.hrl").

manage_schema(install,Context)->
    cria_tabela_setor(Context),
    cria_tabela_horarios(Context),
    cria_tabela_funcionario(Context),
    cria_tabela_movimentacao(Context),
    #datamodel{}.


cria_tabela_setor(Context)->
    case z_db:table_exists(setor,Context) of
        false ->
            z_db:create_table(setor, [
                #column_def{name=id,type="serial",is_nullable=false},
                #column_def{name=descricao,type="varchar",length=50,is_nullable=false}
            ],Context);
        true ->
            ok
    end.


cria_tabela_horarios(Context)->
    case z_db:table_exists(horarios,Context) of
        false ->
            z_db:create_table(horarios, [
                #column_def{name=id,type="serial",is_nullable=false},
                #column_def{name=descricao,type="varchar",length=50,is_nullable=false},
                #column_def{name=dia_semana,type="varchar",length=50,is_nullable=false},
                #column_def{name=hora_inicial,type="timestamptz",is_nullable=false},
                #column_def{name=hora_final,type="timestamptz",is_nullable=false},
                #column_def{name=tolerancia,type="varchar",length=50,is_nullable=false},
                #column_def{name=setor_id,type="integer",is_nullable=true}
            ],Context),
            z_db:q("ALTER TABLE funcionario ADD CONSTRAINT FK_SetorId FOREIGN KEY (setor_id) REFERENCES setor(id)", Context);
        true ->
            ok
    end.


cria_tabela_funcionario(Context)->
    case z_db:table_exists(funcionario,Context) of
    false ->
    z_db:create_table(funcionario, [
    #column_def{name=id,type="serial",is_nullable=false},
    #column_def{name=cpf,type="varchar",length=50,is_nullable=false},
    #column_def{name=nome,type="varchar",length=50,is_nullable=false},
    #column_def{name=ativo,type="integer",is_nullable=false},
    #column_def{name=setor_id,type="integer",is_nullable=true}
    ],Context),
    z_db:q("ALTER TABLE funcionario ADD CONSTRAINT FK_SetorId FOREIGN KEY (setor_id) REFERENCES setor(id)", Context);
    true ->
    ok
    end.

cria_tabela_movimentacao(Context)->
    case z_db:table_exists(movimentacao,Context) of
        false ->
            z_db:create_table(movimentacao, [
                #column_def{name=id,type="serial",is_nullable=false},
                #column_def{name=hora_batida_inicio,type="timestamptz",is_nullable=false},
                #column_def{name=hora_batida_final,type="timestamptz",is_nullable=false},
                #column_def{name=hora_descontada,type="timestamptz",is_nullable=true},
                #column_def{name=hora_extra,type="timestamptz",is_nullable=true},
                #column_def{name=funcionario_id,type="integer",is_nullable=false}
                #column_def{name=horario_id,type="integer",is_nullable=false}
            ],Context),
            z_db:q("ALTER TABLE funcionario ADD CONSTRAINT FK_FuncionarioId FOREIGN KEY (funcionario_id) REFERENCES funcionario(id)", Context),
            z_db:q("ALTER TABLE horarios ADD CONSTRAINT FK_Horario_Id FOREIGN KEY (horario_id) REFERENCES horarios(id)", Context);
        true ->
            ok
    end.
