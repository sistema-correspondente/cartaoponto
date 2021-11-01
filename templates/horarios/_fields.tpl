{% with m.horarios [{get id=id}] as hor %}

    {% print hor %}
    <input type="hidden" id="id" name="id" value="{{ id }}"/>
    <input type="hidden" id="setor_id" name="setor_id" value="{{ 1 }}"/>
    <label>Descrição</label>
    <input type="text" class="form-control" id="descricao" name="descricao" value="{{ hor.descricao }}"/>
    <br>

    <label>Dias de semana trabalhados</label>
    <input type="number" class="form-control" id="semana" name="semana" value="{{ hor.dia_semana }}"/>
    <br>

    <label>Hora Inicial</label>
    <input type="time" class="form-control" id="horaini" name="horaini" value="{{ hor.hora_inicial_srt }}"/>
    <br>

    <label>Hora Final</label>
    <input type="time" class="form-control" id="horafim" name="horafim" value="{{ hor.hora_final_srt }}"/>
    <br>

    <label>Tolerância</label>
    <input type="number" class="form-control" id="tolerancia" name="tolerancia" value="{{ hor.tolerancia }}"/>



{% endwith %}



