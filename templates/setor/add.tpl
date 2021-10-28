{% extends "base.tpl" %}
{% block content_area %}

<div class="container">

    <br>
    <h1 class="text-center"  >Setor - Abensoft</h1>
    {% wire id="new_setor" type="submit" postback={add_setor} delegate="form_ctrl_setor" %}
    <form id="new_setor" method="post" action="postback">
        {% include "setor/_fields.tpl" %}
        <br>
        <button type="submit" class="col-sm-offset-11 btn-success">Salvar</button>
    </form>
</div>
{% endblock %}
