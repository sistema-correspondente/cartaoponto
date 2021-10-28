{% extends "base.tpl" %}
{% block content_area %}


    {% wire id="add_setor_" action={redirect dispatch="add_setor"} %}
    <button id="add_setor_" class="btn btn-primary">Adicionar Setor</button>
    <br>
    <br>
    <h1 class="text-center btn-success"  >Setor</h1>
    <br>
    <table class="table">
        <thead>
            <tr>

                <th scope="col">Setor</th>
                <th scope="col">Editar</th>
                <th scope="col">Excluir</th>
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
            <tr>

            {% endfor %}

    </table>
{% endblock %}
