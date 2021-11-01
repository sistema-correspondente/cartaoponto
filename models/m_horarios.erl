%%%-------------------------------------------------------------------
%%% @author mauricio
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. out 2021 15:16
%%%-------------------------------------------------------------------
-module(m_horarios).
-author("mauricio").
-behaviour(gen_model).
-include_lib("zotonic.hrl").

-export([
    m_find_value/3,
    m_to_list/2,
    m_value/2,
    insert/7,
    get/2,
    update/8,
    delete/2
]).

m_find_value({get, Args}, #m{value = undefined}, Context) ->
    Id = proplists:get_value(id, Args),
    get(Id, Context);


m_find_value({select, Args},#m{value = undefined},Context) ->
    Setor_id = proplists:get_value(setor_id, Args),
    select(Setor_id,Context);


m_find_value(_Key, _Value, _Context) ->
    undefined.

m_to_list(_Value, _Context) ->
    [].

m_value(_, _Context) ->
    undefined.

select(Setor_Id,Context)->
    Sql = "select * from horarios where setor_id = $1",
    Rows = z_db:assoc(Sql,[Setor_Id],Context),
        F = fun(Row) ->
            {H,M,S} = proplists:get_value('hora_inicial',Row),
            {H2,M2,S2} = proplists:get_value('hora_final',Row),
            Rows1 = form_utils:delete_multiple_keys(['hora_inicial','hora_final'],Row),

            [{hora_inicial_srt, z_dateformat:format({{0,0,0}, {H,M,S}},    "H:i", en)},
               {hora_final_srt,   z_dateformat:format({{0,0,0}, {H2,M2,S2}}, "H:i", en)} | Rows1]
            end,
       lists:map(F, Rows).


get(Id, Context) ->
    Sql = "select * from horarios where id = $1",
    case z_db:assoc(Sql, [Id], Context) of
        [R] -> corrige_valores(R, Context);
        _ -> []
    end.

corrige_valores(Value, Context) ->
        HoraInicial = proplists:get_value(hora_inicial,Value),
        HoraFinal = proplists:get_value(hora_final,Value),
        Rows1 = form_utils:delete_multiple_keys(['hora_inicial','hora_final'],Value),
        [{hora_inicial_srt, z_dateformat:format({{0,0,0}, HoraInicial},    "H:i", en)},
         {hora_final_srt,   z_dateformat:format({{0,0,0}, HoraFinal}, "H:i", en)} | Rows1].


insert(Descricao,Semana,Horaini,Horafim,Tolerancia,Setor_id, Context) ->

    Props = [
        {descricao, Descricao},
        {dia_semana, Semana},
        {hora_inicial, Horaini},
        {hora_final, Horafim},
        {tolerancia, Tolerancia},
        {setor_id,Setor_id}
    ],
    z_db:insert("horarios", Props, Context).

delete(Id,Context)->
    ?DEBUG(Id),
    z_db:delete("horarios", Id, Context).

update(Id, Descricao, Semana, Horaini, Horafim, Tolerancia, Setor_id, Context) ->
    Props = [
        {descricao, Descricao},
        {dia_semana, Semana},
        {hora_inicial, Horaini},
        {hora_final, Horafim},
        {tolerancia, Tolerancia},
        {setor_id,Setor_id}
    ],
    z_db:update("horarios", Id, Props, Context).


