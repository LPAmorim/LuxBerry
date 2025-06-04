var database = require("../database/config")

function buscarAlertas(fkEmp) {

    var instrucaoSql = `select idalerta, tipo_alerta, data_hora, fksensor, estufa.nome from alerta
        inner join dadosSensor on fk_registro = iddadossensor
        inner join sensoreslum on fkEstufa = fksensor
        inner join estufa on fkEstufa = idEstufa
        where fkempresa = 1
        order by data_hora desc
        limit 1`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarAlertas
};