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
    update/8,
    delete/2
]).


m_find_value({select, _args},#m{value = undefined},Context) ->
    select(Context);


m_find_value(_Key, _Value, _Context) ->
    undefined.

m_to_list(_Value, _Context) ->
    [].

m_value(_, _Context) ->
    undefined.

select(Context)->
    Sql = "select * from horarios",
    Rows = z_db:assoc(Sql,Context),
        F = fun(Row,{0,Sum,KeyFront,Campo}) ->
        {H,M,S} = proplists:get_value(Campo,Row),
                ?DEBUG(M),
%%            ?DEBUG({hora_inicial_srt, z_dateformat:format({{0,0,0}, {H,M,S}}, "H:i", en)}),

%%            Row1 = proplists:delete(hora_final, Row),

           A = [{KeyFront, z_dateformat:format({{0,0,0}, {H,M,S}}, "H:i", en)}, {}, {} | proplists:delete(Campo, Row)],
            A

        end,
       Result = lists:mapfoldl(F,{0,"hora_inicial_srt","hora_inicial"}, Rows),
        ?DEBUG(Result).
%%       lists:mapfoldl(F,{0,hora_final_srt,hora_final}, Result).

%%    ?DEBUG(Result).
%%     Rows.



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


