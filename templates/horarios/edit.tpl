{% extends "base.tpl" %}
{% block content_area %}
    <div class="container">
        {% wire id="new_horario" type="submit" postback={edit_horarios} delegate="form_ctrl_horario" %}
            <form id="new_horario" metheod="post" action="postback">
                {% include "horarios/_fields.tpl" id=q.id %}
    <br>
                    <button type="submit" class="btn btn-success" >Salvar</button>
            </form>
    </div>
{% endblock %}
