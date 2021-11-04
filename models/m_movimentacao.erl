%%%-------------------------------------------------------------------
%%% @author mauricio
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 01. nov 2021 17:31
%%%-------------------------------------------------------------------
-module(m_movimentacao).
-author("mauricio").
-behaviour(gen_model).
-include_lib("zotonic.hrl").

-export([
    m_find_value/3,
    m_to_list/2,
    m_value/2,
    insert/2,
    get_is_null/2,
    update_movimentacao/2,
    insert_movimentacao/3,
    select_report/2
]).

m_find_value({select, Args}, #m{value = undefined}, Context) ->
    Id = proplists:get_value(id, Args),
    select(Id, Context);

m_find_value({select_report, Args}, #m{value = undefined}, Context) ->
    Id = proplists:get_value(id, Args),
    select_report(Id, Context);

m_find_value(_Key, _Value, _Context) ->
    undefined.

m_to_list(_Value, _Context) ->
    [].

m_value(_, _Context) ->
    undefined.


select(Id, Context) ->
    {Start_day,End_day} = form_utils:get_start_and_end_day(),
    Sql="select * from movimentacao join  funcionario f on f.id = $1
    where hora_batida_inicio BETWEEN $2 AND $3 ",
    Rows = z_db:assoc(Sql,[Id,Start_day,End_day],Context).
%%    ?DEBUG(Rows),
%%    F = fun(Row) ->
%%        Start = proplists:get_value(hora_batida_inicio,Row),
%%        {_,H} = Start,
%%        Finish = proplists:get_value(hora_batida_final,Row),
%%        {_,H1} = Finish,
%%        Rows1 = form_utils:delete_multiple_keys([hora_batida_inicio,hora_batida_final],Row),
%%        [{   start_day, z_dateformat:format({{0,0,0}, H },    "H:i", en)},
%%            {end_day,   z_dateformat:format({{0,0,0}, H1},    "H:i", en)} | Rows1]
%%        end,
%%    lists:map(F, Rows).

get_is_null(Id,Context)->
    {Start_day,End_day} = form_utils:get_start_and_end_day(),
    Sql = "select id from movimentacao
    where hora_batida_inicio BETWEEN $2 AND $3
    and funcionario_id =$1
    and  hora_batida_final isnull",
    case z_db:assoc(Sql, [Id,Start_day,End_day], Context) of
    [R] -> R;
    _ -> []
    end.

update_movimentacao(Id,Context)->
    ?DEBUG("update"),
    Sql ="UPDATE movimentacao SET hora_batida_final = current_timestamp WHERE id = $1",
    z_db:q(Sql,[Id], Context).


insert_movimentacao(Id,Hor_id,Context)->
    ?DEBUG("insert"),
    ?DEBUG(Id),
    ?DEBUG(Hor_id),
    Sql = "insert into movimentacao(funcionario_id,horario_id,hora_batida_inicio)
           values ($1,$2,current_timestamp)",
    z_db:q(Sql,[Id,Hor_id], Context).


select_report(Id,Context)->
%%    ?DEBUG(Id),
    {Start_day,End_day} = form_utils:get_start_and_end_day(),
    Sql="SELECT id, (hora_batida_final) - (hora_batida_inicio) as work_hours from movimentacao
    where hora_batida_inicio  BETWEEN $2 AND $3
    and hora_batida_final is not null and funcionario_id=$1",
    Data = z_db:assoc(Sql, [Id,Start_day,End_day], Context),
    F = fun(Row) ->
        Hours = proplists:get_value(work_hours,Row),
%%        ?DEBUG(Hours),
        {H,_,_}=Hours,
%%        ?DEBUG(H),
        Rows1 = form_utils:delete_multiple_keys([work_hours],Row),
            [{work_hours, z_dateformat:format({{0,0,0}, H},    "H:i:s", en)} | Rows1]
        end,
    lists:map(F, Data).



insert(Id,Context)->
    Nullo = get_is_null(Id,Context),
    Id_update = proplists:get_value(id,Nullo),
    ?DEBUG(Id_update),
    case Id_update == undefined of
    true -> insert_movimentacao(Id,2,Context);
    false -> update_movimentacao(Id_update,Context)
end.
