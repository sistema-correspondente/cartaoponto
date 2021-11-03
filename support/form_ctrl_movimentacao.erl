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



event(#postback{message = {insert_morning_first, _Args}}, Context) ->
    m_movimentacao:insert_morning_first(Context),
    z_render:wire({reload, []}, Context);




event(X,Context)->
    io:format('chegou',[]),

    ?DEBUG(X),
    ?DEBUG(Context),
    Context.

