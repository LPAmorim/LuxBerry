var database = require("../database/config");


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
    order by dataRegistro desc
    `

    return database.executar(instrucaoSql);
};

function plotargrf2(fkSensor) {
    const instrucaoSql = `
select DATE(dataRegistro) as dia,
round(avg(luzRegistrado),2) as media,
round(STDDEV(luzRegistrado),2) as desvioPadrao 
from dadosSensor where fkSensor = ${fkSensor} 
  AND YEARWEEK(dataRegistro, 1) = YEARWEEK(CURDATE(), 1)  -- filtra semana atual
group by dia 
order by dia;
`
    return database.executar(instrucaoSql);

}

module.exports = {
    listarEstufas,
    listarSensores,
    sensorMinMax,
    contarAlertas,
    plotargrf1,
    plotargrf2

}