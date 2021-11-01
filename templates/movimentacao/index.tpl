{% extends "base.tpl" %}
{% block content_area %}

<div class="container">
    <h2>Marcações  </h2>

    <button class="btn btn-primary">Manhã</button>
    <button class="btn btn-primary">Fim Manhã</button>
    <button class="btn btn-primary">Tarde</button>
    <button class="btn btn-primary">Fim Tarde</button>
{{ now }}

{% print m.movimentacao[{select id=1}] %}


    <table class="table">
        <thead>
        <tr>
            <th>Nome</th>
            <th scope="col">Marcação 1</th>
            <th scope="col">Marcação 2</th>
            <th scope="col">Marcação 3</th>
            <th scope="col">Marcação 4</th>
            <th>Horas descontadas</th>
            <th>Horas Extra</th>

        </tr>
        </thead>


    </table>



</div>
{% endblock %}
