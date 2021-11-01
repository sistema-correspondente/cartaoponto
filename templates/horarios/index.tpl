{% extends "base.tpl" %}

{% block content_area %}
    <h1 class="text-center">Cadastro de Hórarios</h1>
    <br>
    <div class="container">
    {%  wire id="add" action={redirect dispatch="horarios_add"} %}
    <button id="add" class="btn btn-primary">Adicionar</button>
        <br>
        <br>
    <table class="table">
        <thead>
        <tr>
            <th>Descrição</th>
            <th>Dias de semana trabalhados</th>
            <th>Hora Inicial</th>
            <th>Hora Final</th>
            <th>Tolerância</th>
            <th>Ediar</th>
            <th>Excluir</th>
        </tr>
        </thead>
        <tbody>
        {% for hor in  m.horarios[{select}] %}
            {% print hor %}
        <tr>
            <td>{{ hor.descricao }}</td>
            <td>{{ hor.dia_semana }}</td>
            <td>
                <input type="time" value={{hor.hora_inicial_srt}}
                       class="form-control" disabled
            ></td>
            <td>
                <input type="time" value={{hor.hora_final}}
                       class="form-control" disabled
                ></td>

            <td>{{ hor.tolerancia }}</td>
            <td>
                {% wire id="del_horario_"|append:hor.id postback={del_horarios id=hor.id} delegate="form_ctrl_horario"%}
                <button id="del_horario_{{hor.id}}" class="btn btn-danger">Excluir </button>
            </td>


        </tr>
        {% endfor %}
        </tbody>
    </table>
    </div>





{% endblock %}
