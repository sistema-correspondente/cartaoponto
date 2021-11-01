{% extends "base.tpl" %}

{% block content_area %}
    <h1 class="text-center">Adição de Horários</h1>
    <br>

    {% wire id="new_time" type="submit" postback={add_horarios} delegate="form_ctrl_horario" %}
    <form id="new_time" method="post" action="postback">
        {% include "horarios/_fields.tpl"%}
        <br>
        <div class="col-sm-1">
            {%  wire id="voltar" action={redirect dispatch="horarios" setor_id=q.setor_id|to_integer} %}
            <button id="voltar" class="btn btn-primary">Voltar</button>
        </div>
        <div class="col-sm-10"></div>
        <div class="col-sm-1">
            <button class="btn btn-success" type="submit">Salvar</button>
        </div>
    </form>


{% endblock %}
