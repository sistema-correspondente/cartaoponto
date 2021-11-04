%% @author Mauricio
%% @copyright 2021 Mauricio
%% Generated on 2021-10-28
%% @doc This site was based on the 'blog' skeleton.

%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.

-module(cartaoponto).
-author("mauricio").
-mod_title("teste zotonic site").
-mod_description("A simple weblog, used as an example of how to create a Zotonic site.").
-mod_prio(10).
-export([manage_schema/2,
         observe_valida_cpf/2]).

-mod_schema(1).
-include_lib("zotonic.hrl").

manage_schema(install, Context)->
    cria_tabela_setor(Context),
    cria_tabela_horarios(Context),
    cria_tabela_funcionario(Context),
    cria_tabela_movimentacao(Context),
    #datamodel{}.


cria_tabela_setor(Context)->
    case z_db:table_exists(setor,Context) of
        false ->
            z_db:create_table(setor, [
                #column_def{name=id,type="serial",is_nullable=false},
                #column_def{name=descricao,type="varchar",length=50,is_nullable=false}
            ],Context);
        true ->
            ok
    end.


cria_tabela_horarios(Context)->
    case z_db:table_exists(horarios,Context) of
        false ->
            z_db:create_table(horarios, [
                #column_def{name=id,type="serial ",is_nullable=false},
                #column_def{name=descricao,type="varchar",length=50,is_nullable=false},
                #column_def{name=dia_semana,type="varchar",length=50,is_nullable=false},
                #column_def{name=hora_inicial,type="time",is_nullable=false},
                #column_def{name=hora_final,type="time",is_nullable=false},
                #column_def{name=tolerancia,type="varchar",length=50,is_nullable=false},
                #column_def{name=setor_id,type="integer",is_nullable=true}
            ],Context),
            z_db:q("ALTER TABLE horarios ADD CONSTRAINT FK_SetorId FOREIGN KEY (setor_id) REFERENCES setor(id)", Context);
        true ->
            ok
    end.


cria_tabela_funcionario(Context)->
    case z_db:table_exists(funcionario,Context) of
        false ->
            z_db:create_table(funcionario, [
                #column_def{name=id,type="serial",is_nullable=false},
                #column_def{name=cpf,type="varchar",length=50,is_nullable=false},
                #column_def{name=nome,type="varchar",length=50,is_nullable=false},
                #column_def{name=ativo,type="integer",is_nullable=false},
                #column_def{name=setor_id,type="integer",is_nullable=true}
            ],Context),
            z_db:q("ALTER TABLE funcionario ADD CONSTRAINT FK_SetorId_F FOREIGN KEY (setor_id) REFERENCES setor(id)", Context);
        true ->
            ok
    end,
    z_db:q("ALTER TABLE funcionario ADD COLUMN  IF NOT EXISTS  rsc_id INTEGER REFERENCES rsc(Id)").


cria_tabela_movimentacao(Context)->
    case z_db:table_exists(movimentacao,Context) of
        false ->
            z_db:create_table(movimentacao, [
                #column_def{name=id,type="serial",is_nullable=false},
                #column_def{name=hora_batida_inicio,type="timestamptz",is_nullable=false},
                #column_def{name=hora_batida_final,type="timestamptz",is_nullable=false},
                #column_def{name=hora_descontada,type="timestamptz",is_nullable=true},
                #column_def{name=hora_extra,type="timestamptz",is_nullable=true},
                #column_def{name=funcionario_id,type="integer",is_nullable=false}
                #column_def{name=horario_id,type="integer",is_nullable=false}
            ],Context),
            z_db:q("ALTER TABLE movimentacao ADD CONSTRAINT FK_Funcionario_M_Id FOREIGN KEY (funcionario_id) REFERENCES funcionario(id)", Context),
            z_db:q("ALTER TABLE movimentacao ADD CONSTRAINT FK_Horario_M_Id FOREIGN KEY (horario_id) REFERENCES horarios(id)", Context);
        true ->
            ok
    end,
    z_db:q("ALTER TABLE movimentacao ADD COLUMN  IF NOT EXISTS  funcionario_id INTEGER REFERENCES funcionario(Id)").



%% The event name passed in your template as event="validate_cpf",
%% prefixed with observe_
observe_valida_cpf({valida_cpf, {postback, Id, Value, Args}}, Context) ->
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
