const { fchown } = require("fs");
var database = require("../database/config");
const { plotargrf2 } = require("../controllers/dashEstufaController");


function listarEstufas(fkempresa){
    const instrucaoSql=`
    select idestufa,
    nome
    from estufa
    where fkempresa = ${fkempresa};
    `
     return database.executar(instrucaoSql);
}

function listarSensores(fkEstufa){
    const instrucaoSql=`
    select 
    idsensores,
    nome
    from sensoreslum
    where fkEstufa = ${fkEstufa};
    `
     return database.executar(instrucaoSql);

}


function plotargrf1(fksensor){
    const instrucaoSql=`
    select luzRegistrado,
    dataRegistro
    from dadosSensor
    where fkSensor = ${fksensor}
    `

    return database.executar(instrucaoSql);
}

// function plotargrf2(){

// }

module.exports={
    listarEstufas,
    listarSensores,
    plotargrf1,
    plotargrf2

}