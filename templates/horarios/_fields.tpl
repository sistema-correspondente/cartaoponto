{% with m.horarios [{get id=id}] as hor %}

{% print q.setor_id|to_integer %}
    <input type="hidden" id="id" name="id" value="{{ id }}"/>
    <input type="hidden" id="setor_id" name="setor_id" value="{{ q.setor_id|to_integer }}"/>
    <label>Descrição</label>
    <input type="text" class="form-control" id="descricao" name="descricao" value="{{ hor.descricao }}"/>
    {% validate id="descricao" type={presence failure_message="Por favor, informe uma Descrição!"} %}


    <br>

    <label>Dias de semana trabalhados</label>
    <input type="number" class="form-control" id="semana" name="semana" value="{{ hor.dia_semana }}"/>
    {% validate id="semana" type={presence failure_message="Por favor, informe os dias trabalhados!"} %}

    <br>

    <label>Hora Inicial</label>
    <input type="time" class="form-control" id="horaini" name="horaini" value="{{ hor.hora_inicial_srt }}"/>s
    <br>

    <label>Hora Final</label>
    <input type="time" class="form-control" id="horafim" name="horafim" value="{{ hor.hora_final_srt }}"/>
    <br>

    <label>Tolerância</label>
    <input type="number" class="form-control" id="tolerancia" name="tolerancia" value="{{ hor.tolerancia }}"/>
    {% validate id="tolerancia" type={presence failure_message="Por favor, informe a tolerância permitida!"} %}


{% endwith %}



