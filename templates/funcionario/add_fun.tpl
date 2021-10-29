{% extends "page.tpl" %}
{% block content_area %}

    <h1>Cadastro - Funcionario</h1>
    <div class="container">

         {%  wire id="novo_funcionario" type="submit" postback={add_funcionario} delegate="form_ctrl_fun" %}
         <form id="novo_funcionario" method="post" action="postback">

             {%  include "funcionario/fun_fields.tpl" %}
             {#  inserir botao de voltar  #}

              {%  wire id="voltar" action={redirect dispatch="funcionario"} %}
                <button id="voltar"  class="btn btn-danger">Voltar </button>


             <button type="submit" class="btn btn-success">Salvar</button>
        </form>
    </div>

                                                    {# carinha feliz :) #}

                                                      <p>&#128512;</p>

{% endblock %}
