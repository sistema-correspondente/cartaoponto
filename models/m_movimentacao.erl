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
    m_value/2
]).

m_find_value({select, Args}, #m{value = undefined}, Context) ->
    Id = proplists:get_value(id, Args),
    select(Id, Context);


m_find_value(_Key, _Value, _Context) ->
    undefined.

m_to_list(_Value, _Context) ->
    [].

m_value(_, _Context) ->
    undefined.


select(Id, Context) ->
    Sql = "select * from movimentacao left join  funcionario f on f.id =  $1",
    z_db:assoc(Sql,[Id],Context).




