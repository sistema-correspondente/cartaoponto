%%%-------------------------------------------------------------------
%%% @author abensoft
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. out 2021 14:59
%%%-------------------------------------------------------------------
-module(form_ctrl_setor).
-author("abensoft").

-include_lib("zotonic.hrl").
-export([event/2, fields/1]).

fields(Args1) ->
    Descricao = proplists:get_value("descricao", Args1),
    Descricao.


event(#submit{message = {add_setor, Args}}, Context) ->
    Args1 = lists:merge(Args, z_context:get_q_all(Context)),
    Descricao = form_ctrl_setor:fields(Args1),

    m_setor:insert(Descricao, Context),
    z_render:wire({redirect, [{dispatch, "setor"}]}, Context);




event(#submit{message = {edit_setor, Args}}, Context) ->
    Args1 = lists:merge(Args, z_context:get_q_all(Context)),
    Descricao = form_ctrl_setor:fields(Args1),
    Id = z_utils:depickle(proplists:get_value("id", Args1), Context),


    m_setor:update(Id, Descricao, Context),
    z_render:wire({redirect, [{dispatch, "setor"}]}, Context);


event(#postback{message = {del_setor, Args}}, Context) ->
    Id = proplists:get_value(id, Args),
    m_setor:delete(Id, Context),
    z_render:wire({reload,[]}, Context);


event(X,Context)->
    io:format('chegou',[]),

    ?DEBUG(X),
    ?DEBUG(Context),
    Context.

