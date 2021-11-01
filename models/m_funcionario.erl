%%%-------------------------------------------------------------------
%%% @author abensoft
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. out 2021 18:11
%%%-------------------------------------------------------------------
-module(m_funcionario).
-author("abensoft").

%% API
-export([]).

-behaviour(gen_model).
-include_lib("zotonic.hrl").
-export([
    m_find_value/3,
    m_to_list/2,
    m_value/2,
    update/6,
    get/2,
    delete/2,
    select/1,
    select_setor/1,
    insert/6
]).




m_find_value({get, Args}, #m{value = undefined}, Context) ->
    Id = proplists:get_value(id, Args),
    get(Id, Context);

m_find_value({select, _Args}, #m{value = undefined}, Context) ->
    select(Context);

m_find_value({select_setor, _Args}, #m{value = undefined}, Context) ->
    select_setor(Context);

m_find_value(_Key, _Value, _Context) ->
    undefined.

m_to_list(_Value, _Context) ->
    [].

m_value(_, _Context) ->
    undefined.

select( Context) ->
    Sql = "select
                *
           from funcionario
           left join setor  on
                funcionario.setor_id = setor.id
           order by funcionario.nome",
    z_db:assoc(Sql, Context).


select_setor( Context) ->
    Sql = "select * from setor",
    z_db:assoc(Sql, Context).



insert(Cpf, Nome, Ativo, Setor_id, RscId, Context) ->
    Props = [
        {cpf, Cpf},
        {nome, Nome},
        {ativo, Ativo},
        {setor_id, Setor_id},
        {rsc_id, RscId}
    ],
    ?DEBUG(Props),
    z_db:insert("funcionario", Props, Context).

get(Id, Context) ->
    Sql ="select * from funcionario where id = $1",
    case z_db:assoc(Sql, [Id], Context) of
        [R] -> R;
        _ -> []
    end.

update(Id, Cpf, Nome, Ativo, Setor_id, Context) ->
    Props = [
        {cpf, Cpf},
        {nome, Nome},
        {ativo, Ativo},
        {setor_id, Setor_id}


    ],
    F = fun(Ctx) ->
        z_db:update("funcionario", Id, Props, Ctx)
        end,
    z_db:transaction(F, Context).


delete(Id, Context) ->
    F = fun(Ctx) ->
            Funcionario = get(Id, Ctx),
            ?DEBUG(Funcionario),
            RscId = proplists:get_value(rsc_id, Funcionario),
            ?DEBUG(RscId),
            z_db:delete("funcionario", Id, Ctx),
            m_rsc:delete(RscId, Ctx)
        end,
    z_db:transaction(F, Context).
