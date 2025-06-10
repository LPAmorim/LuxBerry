var database = require("../database/config");


function listarEstufas(fkempresa){
    const instrucaoSql=`
    select idestufa,
    nome
    from estufa
    where fkempresa = ${fkempresa};
    `
    return database.executar(instrucaoSql);
}


function puxarHistoricoInteiro(fkempresa){
    const instrucaoSql=`
    select a.tipo_alerta,
        est.nome,
        sen.idsensores,
        date_format(a.data_hora, '%d/%m/%Y' ' %H:%i:%s') as dataFormatada
    from alerta a
    join dadosSensor ds on a.fk_registro = ds.iddadossensor
    join sensoreslum sen on ds.fkSensor = sen.idsensores
    join estufa est on sen.fkEstufa = est.idestufa
    where est.fkempresa = ${fkempresa}
    order by a.data_hora desc;
    `
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function puxarHistoricoPorEstufa(fkEstufa){
    const instrucaoSql=`
    select a.tipo_alerta,
        est.nome,
        sen.idsensores,
        date_format(a.data_hora, '%d/%m/%Y' ' %H:%i:%s') as dataFormatada
    from alerta a
    join dadosSensor ds on a.fk_registro = ds.iddadossensor
    join sensoreslum sen on ds.fkSensor = sen.idsensores
    join estufa est on sen.fkEstufa = est.idestufa
    where sen.fkEstufa = ${fkEstufa}
    order by a.data_hora desc;
    `
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


module.exports={
    listarEstufas,
    puxarHistoricoInteiro,
    puxarHistoricoPorEstufa
}