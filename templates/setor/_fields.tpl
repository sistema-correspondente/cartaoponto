{% with m.setor [{get id=id}] as setor %}
    <input type="hidden" id="id" name="id" value="{{ id|pickle }}"/>
<div class="row">
    <div class="col-sm-5">
        <label>Setor</label>
        <input type="text" class="form-control" id="descricao" name="descricao" placeholder="Setor" value="{{ setor.descricao }}">
    {% validate id="descricao" type={presence failure_message="Por favor, informe um Setor!"} %}

    </div>
</div>
{% endwith %}
