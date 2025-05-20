var database = require("../database/config")

function buscarInfoDash(fkEmp) {

    var instrucaoSql = `select dad.luzRegistrado lux,
		dad.fkSensor sensor,
        est.idEstufa,
		est.nome,
        emp.nomeEmpresa Empresa
from dadosSensor dad
inner join (
    select fkSensor, max(dataRegistro) as ultimaData
    from dadosSensor
    group by fkSensor
) ult on dad.fkSensor = ult.fkSensor and dad.dataRegistro = ult.ultimaData
inner join sensoreslum sen on dad.fkSensor = sen.idsensores
inner join estufa est on sen.fkEstufa = est.idEstufa
inner join empresa emp on est.fkEmpresa = emp.idEmpresa
where idEmpresa = ${fkEmp}
order by fkEstufa;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarInfoDash
};