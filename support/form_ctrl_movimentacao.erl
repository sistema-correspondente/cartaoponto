%%%-------------------------------------------------------------------
%%% @author mauricio
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 01. nov 2021 17:45
%%%-------------------------------------------------------------------
-module(form_ctrl_movimentacao).
-author("mauricio").

%% API
-include_lib("zotonic.hrl").
-export([event/2]).

event(#postback{message = {insert, Args}}, Context) ->
    Args1 = lists:merge(Args,z_context:get_q_all(Context)),
    Id = proplists:get_value(id, Args1),
    m_movimentacao:insert(Id,Context),
    z_render:wire({reload, []}, Context);

event(X,Context)->
    io:format('chegou',[]),

    ?DEBUG(X),
    ?DEBUG(Context),
    Context.
