var database = require("../database/config")

function buscarAlertas(fkEmp) {

    var instrucaoSql = `select a.idalerta, a.tipo_alerta, date_format(a.data_hora, '%d/%m/%Y' ' %H:%i:%s') as dataFormatada, d.fksensor, e.nome from alerta a
        inner join dadosSensor d on fk_registro = iddadossensor
        inner join sensoreslum s on d.fkSensor = s.idsensores
        inner join estufa e on fkEstufa = idEstufa
        where fkempresa = ${fkEmp}
        order by data_hora desc
        limit 1;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarAlertas
};