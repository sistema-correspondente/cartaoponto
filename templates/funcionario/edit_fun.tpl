 {% extends "page.tpl" %}

{% block content_area %}
    <h1>Editando funcionario </h1>
    <div class="container">

        {% wire id="novo_funcionario" type="submit" postback={edit_funcionario} delegate="form_ctrl_fun" %}
        <form id="novo_funcionario" method="post" action="postback">

            {% include "funcionario/fun_fields.tpl" id=id %}

            {%  wire id="voltar" action={redirect dispatch="funcionario"} %}
            <button id="voltar"  class="btn btn-danger">Voltar </button>
            <button type="submit" class="btn btn-success">Salvar</button>
        </form>
    </div>

{% endblock %}
