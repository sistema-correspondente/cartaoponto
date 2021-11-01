{% extends "base.tpl" %}
{% block content_area %}

    {% wire id="add_setor_" action={redirect dispatch="add_setor"} %}
    <button id="add_setor_" class="col-sm-3 btn btn-primary">Adicionar Setor</button>
    <br>
    <br>
    <h1 class="text-center"  >Setor - Abensoft</h1>
    <br>
    <table class="table">
        <thead>
            <tr>

                <th scope="col">SETOR:</th>
                <th scope="col">EDITAR:</th>
                <th scope="col">EXCLUIR:</th>
                <th>Horários</th>
            </tr>
        </thead>

            {% for setor in m.setor[{select}] %}
            <tr>
                <th scope="row"> {{ setor.descricao }} </th>
                <td>
                    {% wire id="edit_setor_"|append:setor.id action={redirect dispatch="edit_setor" id=setor.id} %}
                    <button id="edit_setor_{{ setor.id }}" class="btn btn-warning">Editar Setor</button>
                </td>
                <td>
                    {% wire  id="del_setor_"|append:setor.id postback={del_setor id=setor.id} delegate="form_ctrl_setor" %}
                    <button id="del_setor_{{setor.id}}" class="btn btn-danger">Excluir Setor</button>
                </td>
                <td>
                    {% wire  id="go_to"|append:setor.id action={redirect dispatch="horarios" setor_id=setor.id}  %}
                    <button id="go_to{{setor.id}}" class="btn btn-primary">Horários</button>
                </td>
            <tr>

            {% endfor %}

    </table>
{% endblock %}
