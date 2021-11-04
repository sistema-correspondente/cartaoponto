{% extends "base.tpl" %}
{% block content_area %}

<div class="container">
{#    {% wire id="insert_morning_first" action={add_class target="insert_morning_first" class="disabled"} %}#}
    <button id="insert" class="btn btn-primary">Marcações</button>
    {% wire  id="insert" postback={insert id=1} delegate="form_ctrl_movimentacao" %}
{{ now }}
    <br>
    <br>
<div class="row">
    <div class="col-sm-6">
{#            {% print  m.movimentacao[{select id=1}]  %}#}
            <table class="table">
                <thead>
                <tr>
                    <th>Nome</th>
                    <th >Marcação </th>
                    <th >Marcação </th>
                </tr>
                </thead>
                {% for mov in m.movimentacao[{select id=1}] %}
                <tr>
                    <th>{{ mov.nome|upper }}</th>
                    <th>{{ mov.hora_batida_inicio | date:"h:i"  }}</th>
                    <th>{{ mov.hora_batida_final | date:"h:i" }}</th>
                </tr>
                {% endfor %}
            </table>
    </div>
    <div class="col-sm-6">
{#        {% print m.movimentacao[{select_report id=1}] %}#}
            <table class="table">
                <thead>
                <tr>
                    <th>Horas Trabalhadas</th>
                </tr>
                </thead>
                {%  for rep in  m.movimentacao[{select_report id=1}] %}
                <tr>
                    <th>{{  rep.work_hours }} </th>
                </tr>
                {% endfor %}
            </table>

    </div>
</div>



</div>
{% endblock %}
