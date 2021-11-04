%%%-------------------------------------------------------------------
%%% @author abensoft
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 04. nov 2021 14:48
%%%-------------------------------------------------------------------
-module(m_permissao).
-author("abensoft").

%% API
-export([]).

{% print m.acl.user %}
{% print m.rsc[m.acl.user].o.hasusergroup %}
{% print m.rsc[m.acl.user].o.hasusergroup[1] %}
{% print m.rsc[m.rsc[m.acl.user].o.hasusergroup[1]].name  == "acl_user_group_managers" %}


tem_permissao(UsrId, Tag, Context) ->
UserGroup = <<"acl_user_group_managers">>,
tem_permissao_tela(UserGroup, Tag, Context).

tem_permissao_tela(<<"acl_user_group_managers">>, cad_setor, _Context) ->
    true;
tem_permissao_tela(_, cad_setor, _Context) ->
    false;
