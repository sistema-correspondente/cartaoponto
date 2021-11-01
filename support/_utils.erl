%%%-------------------------------------------------------------------
%%% @author mauricio
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. out 2021 15:45
%%%-------------------------------------------------------------------
-module('_utils').
-author("mauricio").

%% API
-export([tranformaHoraParaTupla/1]).


tranformaHoraParaTupla(Time)->
    Res = string:split(Time,":"),
    [H,M] = Res,
    {list_to_integer(H),list_to_integer(M),00}.
