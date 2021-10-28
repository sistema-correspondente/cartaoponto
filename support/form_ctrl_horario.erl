%%%-------------------------------------------------------------------
%%% @author mauricio
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. out 2021 15:14
%%%-------------------------------------------------------------------
-module(form_ctrl_horario).
-author("mauricio").

%% API
-include_lib("zotonic.hrl").
-export([event/2]).

event(#submit{message = {add_horarios,Args}},Context)->
%%    ?DEBUG(Args),
%%    ?DEBUG(z_context:get_q_all(Context)),
    Args1 = lists:merge(Args,z_context:get_q_all(Context)),
    Descricao = proplists:get_value("descricao", Args1),
    Semana = list_to_integer(proplists:get_value("semana", Args1)),
    Horaini = "13:15:00",
%%        proplists:get_value("horaini", Args1),
    Horafim = "12:00:00",
%%        proplists:get_value("horafim", Args1),
    Tolerancia = list_to_integer(proplists:get_value("tolerancia", Args1)),
    Setor_id = proplists:get_value("setor_id", Args1),
    horarios:insert(Descricao,Semana,Horaini,Horafim,Tolerancia,Setor_id,Context),
    z_render:wire({redirect, [{dispatch, "horarios"}]},
        Context);



event(X,Context)->
    io:format('chegou',[]),

    ?DEBUG(X),
    ?DEBUG(Context),
    Context.

