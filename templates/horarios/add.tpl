{% extends "base.tpl" %}

{% block content_area %}

    <h1 class="text-center">Adição de Horários</h1>
    {% wire id="new_time" type="submit" postback={add_horarios} delegate="form_ctrl_horario" %}

    <form id="new_time" method="post" action="postback">
        {% include "horarios/_fields.tpl"  %}
        <br>
    <button class="btn btn-success" type="submit">Salvar</button>
    </form>


{% endblock %}
