var database = require("../database/config")

function buscarInfoDash(fkEmp) {

    var instrucaoSql = `select sensoreslum.nome as nomeSens, fkSensor as sensor, luzRegistrado lux, idEstufa, estufa.nome, max(dataRegistro) from sensoreslum
inner join dadosSensor on fkSensor = idsensores
inner join estufa on fkEstufa = idEstufa
where fkEmpresa = ${fkEmp}
group by fkSensor, luzRegistrado
having max(dataRegistro) = (select max(dataRegistro) from dadosSensor where fkSensor = sensor);`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarInfoDash,
};