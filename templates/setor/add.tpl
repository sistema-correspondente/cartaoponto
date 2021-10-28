{% extends "base.tpl" %}
{% block content_area %}

<div class="container">

    {% wire id="new_setor" type="submit" postback={add_setor} delegate="form_ctrl_setor" %}
    <form id="new_setor" method="post" action="postback">
        {% include "setor/_fields.tpl" %}
        <br>
        <button type="submit" class="btn btn-success">Salvar</button>
    </form>
</div>
{% endblock %}
