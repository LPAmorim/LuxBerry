const { fchown } = require("fs");
var database = require("../database/config")


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
module.exports={
    listarEstufas,
    listarSensores

}