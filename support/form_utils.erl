%%%-------------------------------------------------------------------
%%% @author mauricio
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. out 2021 15:45
%%%-------------------------------------------------------------------
-module(form_utils).
-author("mauricio").

%% API
-export([tranform_hour_to_tuple/1,
        delete_multiple_keys/2,
        to_integer/1]).

tranform_hour_to_tuple(Time)->
    Res = string:split(Time,":"),
    [H,M] = Res,
    {list_to_integer(H),list_to_integer(M),00}.

delete_multiple_keys([],Arr)->
    Arr;

delete_multiple_keys([Key|Keys],Arr)->
    Arr1 = proplists:delete(Key, Arr),
    delete_multiple_keys(Keys,Arr1).


to_integer(undefined) -> undefined;
to_integer(Valor) when is_binary(Valor)->
    binary_to_integer(Valor);
to_integer(Valor) when is_float(Valor)->
    float_to_list(Valor);
to_integer(Valor) when is_list(Valor) ->
    list_to_integer(Valor);
to_integer(Valor) ->
    Valor.


