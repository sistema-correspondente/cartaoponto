%%%-------------------------------------------------------------------
%%% @author abensoft
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. out 2021 14:35
%%%-------------------------------------------------------------------
-module(m_setor).
-author("abensoft").
-behaviour(gen_model).
-include_lib("zotonic.hrl").

-export([
    m_find_value/3,
    m_to_list/2,
    m_value/2,
    get/2,
    update/3,
    delete/2,
    select/1
]).

-export([insert/2]).

m_find_value({select, _Args}, #m{value = undefined}, Context) ->
    select(Context);


m_find_value({get, Args}, #m{value = undefined}, Context) ->
    Id = proplists:get_value(id, Args),
    get(Id, Context);

m_find_value(_Key, _Value, _Context) ->
    undefined.

m_to_list(_Value, _Context) ->
    [].

m_value(_, _Context) ->
    undefined.


select(Context)->
    Sql = "select * from setor",
    z_db:assoc(Sql,Context).


insert(Descricao, Context) ->
    Props = [
        {descricao, Descricao}
    ],
    z_db:insert("setor", Props, Context).


get(Id, Context) ->
    Sql = "select * from setor where id = $1",
    case z_db:assoc(Sql, [Id], Context) of
        [R] -> R;
        _ -> []
    end.

update(Id, Descricao, Context) ->
    Props = [
        {descricao, Descricao}
    ],
    z_db:update("setor", Id, Props, Context).

delete(Id,Context)->
    z_db:delete("setor", Id, Context).



