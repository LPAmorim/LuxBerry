var database = require("../database/config");
const { plotargrf2 } = require("../controllers/dashEstufaController");


function listarEstufas(fkempresa) {
    const instrucaoSql = `
    select idestufa,
    nome
    from estufa
    where fkempresa = ${fkempresa};
    `
    return database.executar(instrucaoSql);
}

function listarSensores(fkEstufa) {
    const instrucaoSql = `
    select 
    idsensores,
    nome
    from sensoreslum
    where fkEstufa = ${fkEstufa};
    `
    return database.executar(instrucaoSql);

}

function sensorMinMax(fkSensor) {
    var instrucaoSql = `
         SELECT 
            MAX(luzRegistrado) AS maior,
            MIN(luzRegistrado) AS menor
        FROM dadosSensor
        WHERE fkSensor = ${fkSensor}
          AND DATE(dataRegistro) = CURDATE();
    `;

    return database.executar(instrucaoSql, [fkSensor]);
}

function contarAlertas(fkSensor) {
    const instrucaoSql = `
        select count(*) as totalAlertas
        from alerta a
        join dadosSensor d ON a.fk_registro = d.iddadossensor
        where d.fkSensor = ${fkSensor}
        and DATE(a.data_hora) = CURDATE();
    `;
   return database.executar(instrucaoSql, [fkSensor]);
}


function plotargrf1(fksensor) {
    const instrucaoSql = `
    select luzRegistrado,
    dataRegistro
    from dadosSensor
    where fkSensor = ${fksensor}
    `

    return database.executar(instrucaoSql);
}

// function plotargrf2(){

// }

module.exports = {
    listarEstufas,
    listarSensores,
    sensorMinMax,
    contarAlertas,
    plotargrf1,
    plotargrf2

}