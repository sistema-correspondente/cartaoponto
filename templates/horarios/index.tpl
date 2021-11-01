{% extends "base.tpl" %}

{% block content_area %}
    <h1 class="text-center">Cadastro de Horários</h1>
    <br>
    <div class="container">
    <div class="col-sm-1">
        {%  wire id="voltar" action={redirect dispatch="setor"} %}
        <button id="voltar" class="btn btn-primary">Voltar</button>
    </div>
    <div class="col-sm-10"></div>
    <div class="col-sm-1">
        {%  wire id="add" action={redirect dispatch="horarios_add" setor_id=q.setor_id|to_integer } %}
        <button id="add" class="btn btn-primary">Adicionar</button>
    </div>

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
            <th>Editar</th>
            <th>Excluir</th>
        </tr>
        </thead>
        <tbody>
        {% if m.horarios[{select setor_id= q.setor_id | to_integer }] %}
        {% for hor in  m.horarios[{select setor_id= q.setor_id | to_integer }] %}
        <tr>
            <td>{{ hor.descricao }}</td>
            <td>{{ hor.dia_semana }}</td>
            <td>
                <input type="time" value={{hor.hora_inicial_srt}}
                       class="form-control" disabled
            ></td>
            <td>
                <input type="time" value={{hor.hora_final_srt}}
                       class="form-control" disabled
                ></td>

            <td>{{ hor.tolerancia }}</td>
            <td>
                {% wire id="horarios_edit_"|append:hor.id action={redirect dispatch="horarios_edit" id=hor.id setor_id=q.setor_id|to_integer } %}
                <button id="horarios_edit_{{ hor.id }}" class="btn btn-warning"> Editar</button>
            </td>
            <td>
                {% wire id="del_horario_"|append:hor.id postback={del_horarios id=hor.id} delegate="form_ctrl_horario"%}
                <button id="del_horario_{{hor.id}}" class="btn btn-danger">Excluir </button>
            </td>
        </tr>
        {% endfor %}
        {% else %}
            <tr>
                <td class="text-center" colspan="7">
                    <div class="alert alert-danger">
                        <strong>Atenção!</strong> Nenhum Horário cadastrado.
                    </div>
                </td>
            </tr>
        {% endif %}


        </tbody>
    </table>


    </div>





{% endblock %}
