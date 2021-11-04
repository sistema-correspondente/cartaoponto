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
        valida_cpf/1,
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

valida_cpf(S) ->
    C = normalizar(lists:filter(fun(X) -> X>47 andalso X<58 end, S)),
    D = lists:sum( lists:zipwith(fun(X,Y) -> (X-48)*Y end, C, [1,2,3,4,5,6,7,8,9,0,0]) ) rem 11,
    D =:= lists:nth(10, C) - 48 andalso
        ( lists:sum(lists:zipwith(fun(X,Y) -> (X-48)*Y end, C, [0,1,2,3,4,5,6,7,8,0,0]) ) + D * 9 ) rem 11 =:= lists:nth(11, C) - 48.


%% Internal functions
%% ====================================================================
normalizar(S) when length(S) < 11 -> normalizar("0" ++ S);
normalizar(S) when length(S) =:= 11 -> S;
normalizar(S) when length(S) > 11 -> lists:sublist(S, 11).


