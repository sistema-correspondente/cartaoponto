{% extends "base.tpl" %}
{% block content_area %}
    <div class="container">

        {% wire id="new_horario" type="submit" postback={edit_horarios} delegate="form_ctrl_horario" %}
            <form id="new_horario" metheod="post" action="postback">
                {% include "horarios/_fields.tpl" id=id |to_integer setor_id=q.setor_id|to_integer  %}
    <br>
                <div class="col-sm-1">
                    {%  wire id="voltar" action={redirect dispatch="horarios" setor_id=q.setor_id|to_integer} %}
                    <button id="voltar" class="btn btn-primary">Voltar</button>
                </div>
                <div class="col-sm-10"></div>
                <div class="col-sm-1">
                    <button class="btn btn-success" type="submit">Salvar</button>
                </div>            </form>
    </div>
{% endblock %}
