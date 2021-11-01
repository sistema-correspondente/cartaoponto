{%  with m.funcionario [{get id=id}] as funcionario  %}

<input type="hidden" id="id" name="id" value="{{ id|pickle }}"/>
    <input type="hidden" id="rsc_id" name="rsc_id" value="{{ funcionario.rsc_id|pickle }}"/>
<label for="cpf">CPF:</label>
<input type="text" id="cpf" name="cpf" class="form-control" value="{{ funcionario.cpf }}" placeholder="000.000.000-00"/>
{% validate id="cpf" type={presence message_failure="Campo Obrigatório."} message_after="cpf" %}

<label for="nome">Nome:</label>
<input type="text" id="nome" name="nome" class="form-control" value="{{ funcionario.nome }}"/>
{% validate id="nome" type={presence message_failure="Campo Obrigatório."} message_after="nome" %}


        <input type="checkbox" id="ativo" name="ativo"
        {% if funcionario.ativo == 1 %}
            checked
       {% endif %}
        >
        <label for="ativo"> Funcionário  Ativo </label>

        <br>
        <br>

        <label for="setor_id">Setor (select one):</label>
        <select class="form-control" id="setor_id" name="setor_id">

            {% for setor in m.funcionario[{select_setor}]%}

            <option  value={{ setor.id }}>{{ setor.descricao }}</option>
            {% endfor %}
        </select>



{% endwith %}
