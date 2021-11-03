{% extends "base.tpl" %}
{% block content_area %}

<div class="container">
    <h2>Marcações  </h2>

{#    {% wire id="insert_morning_first" action={add_class target="insert_morning_first" class="disabled"} %}#}
    <button id="insert_morning_first" class="btn btn-primary">Manhã</button>
    {% wire  id="insert_morning_first" postback={insert_morning_first} delegate="form_ctrl_movimentacao" %}
    <button  class="btn btn-primary">Fim Manhã</button>
    <button class="btn btn-primary">Tarde</button>
    <button class="btn btn-primary">Fim Tarde</button>
{{ now }}

{% print m.movimentacao[{select id=1}] %}
 {% with m.movimentacao[{select id=1}] as mov %}


    <table class="table">
        <thead>
        <tr>
            <th>Nome</th>
            <th >Marcação 1</th>
            <th >Marcação 2</th>
            <th >Marcação 3</th>
            <th >Marcação 4</th>
            <th>Horas descontadas</th>
            <th>Horas Extra</th>
        </tr>
        </thead>
        <tr>
            <th>{{ mov.nome[1] }}</th>
        </tr>

    </table>

    {% endwith %}

</div>
{% endblock %}
