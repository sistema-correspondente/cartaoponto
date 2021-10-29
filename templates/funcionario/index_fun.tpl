{%  extends "page.tpl" %}

{% block content_area %}
    {%  wire id="add_funcionario" action={redirect dispatch="add_funcionario"} %}
    <button id="add_funcionario" class="btn btn-success">Adicionar</button>

    <div class="container">
    <table class="table">
    <thead>
    <tr>
        <th>Cpf       </th>
        <th>Nome      </th>
        <th>ativo     </th>
        <th>Setor     </th>
        <th>...       </th>
    </tr>
    </thead>

 <tbody>
    {%  for funcionario in m.funcionario[{select}] %}
        <tr>
            <td> {{ funcionario.cpf }} </td>
            <td> {{ funcionario.nome }}</td>
            <td> {{ funcionario.ativo }}</td>
            <td> {{ funcionario.setor_id }}</td>
            <td>
                {% wire id="edit_funcionario_"|append:funcionario.id action={redirect dispatch="edit_funcionario" id=funcionario.id} %}
                 <button id="edit_funcionario_{{ funcionario.id }}" class="btn btn-sm btn-warning">Editar</button>

                {% wire id="del_fun"|append:funcionario.id postback={del_funcionario id = funcionario.id} delegate="form_ctrl_fun"  %}
                <button id="del_fun{{ funcionario.id }}" class="btn btn-sm btn-danger">Excluir</button>
            </td>
        </tr>
    {% endfor %}
 </tbody>
    </table>
    </div>

{% endblock %}
