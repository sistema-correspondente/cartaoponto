%%%-------------------------------------------------------------------
%%% @author abensoft
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. out 2021 16:24
%%%-------------------------------------------------------------------
-module(form_ctrl_fun).
-author("abensoft").
-include_lib("zotonic.hrl").
%% API
-export([event/2,
        fields/1,
    observe_validate_cpf/2]).

fields(Args1)->
    Cpf = proplists:get_value("cpf", Args1),
    Nome = proplists:get_value("nome", Args1),
    Ativo = proplists:get_value("ativo", Args1),
    Ativo1 = case Ativo == "on" of
                 true -> 1;
                 _ -> 0
             end,
    Setor = list_to_integer(proplists:get_value("setor_id", Args1)),
    {Cpf, Nome, Ativo1, Setor}.

event(#submit{message ={add_funcionario, Args}}, Context) ->

    ?DEBUG(Args),
    ?DEBUG(z_context:get_q_all(Context)),
    Args1 = lists:merge(Args, z_context:get_q_all(Context)),
    {Cpf, Nome, Ativo1, Setor}=form_ctrl_fun:fields(Args1),

    {ok, CatId} = m_category:name_to_id(person, Context),
    {ok, RscId} = m_rsc:insert([{title, Nome}, {category_id, CatId }], Context),
    m_funcionario:insert(Cpf, Nome, Ativo1, Setor, RscId, Context),
    z_render:wire({redirect, [{dispatch,"funcionario" }]}, Context );


event(#submit{message = {edit_funcionario, Args}}, Context) ->
    Args1 = lists:merge(Args, z_context:get_q_all(Context)),
    ?DEBUG(Args1),
    Id = z_utils:depickle(proplists:get_value("id", Args1), Context),
    {Cpf, Nome, Ativo1, Setor}=form_ctrl_fun:fields(Args1),
    RscId = z_utils:depickle(proplists:get_value("rsc_id", Args1), Context),
    m_rsc:update(RscId, [{title, Nome}], Context),
    m_funcionario:update(Id, Cpf, Nome, Ativo1, Setor,  Context),
%%    z_notifier:notify({   }),
    z_render:wire({redirect, [{dispatch, "funcionario"}]}, Context);



event(#postback{message={del_funcionario, Args}}, Context ) ->
    Id = proplists:get_value(id, Args),
    m_funcionario:delete(Id, Context),
    z_render:wire({reload, []}, Context);

event(X, Context) ->
    ?DEBUG(X),
    ?DEBUG(Context),
    Context.


%% The event name passed in your template as event="validate_cpf",
%% prefixed with observe_
observe_validate_cpf({valida_cpf, {postback, Id, Value, Args}}, Context) ->
    ?DEBUG(Value),
    ?DEBUG(Args),
    ?DEBUG(Id),
    ?DEBUG(Context),
    case form_utils:valida_cpf(Value) of
        true ->
            {{ok, Value}, Context};
        false ->
            %% The validation message will be shown in the form
            {{error, Id, "invalido."}, Context}
    end.
