var dashEstufaModel = require("../models/dashEstufaModel");

function listarEstufas(req, res) {
    const fkempresa = req.params.fkempresa;

    dashEstufaModel.listarEstufas(fkempresa)
        .then(result => {
            if (result.length > 0) {
                res.status(200).json(result);
            } else {
                res.status(204).send("Nenhuma estufa encontrada.");
            }
        })
        .catch(erro => {
            console.error("Erro ao buscar estufas:", erro);
            res.status(500).json(erro);
        });
}

function listarSensores(req, res){
    const fkEstufa = req.params.fkEstufa;

    dashEstufaModel.listarSensores(fkEstufa)
        .then(result => {
            if (result.length > 0) {
                res.status(200).json(result);
            } else {
                res.status(204).send("Nenhum sensor encontrado.");
            }
        })
        .catch(erro => {
            console.error("Erro ao buscar sensores:", erro);
            res.status(500).json(erro);
        });
}

function sensorMinMax(req, res) {
    const fkSensor = req.params.fksensor; 

    dashEstufaModel.sensorMinMax(fkSensor)
    .then((resultado) => {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(200).json([]);
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar os dados do sensor: ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function contarAlertas(req, res) {
    const fkSensor = req.params.fksensor;

    dashEstufaModel.contarAlertas(fkSensor)
    .then((resultado) => {
        if (resultado.length > 0) {
            res.status(200).json(resultado[0]);
        } else {
            res.status(200).json({ total_alertas: 0 });
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao contar os alertas: ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}


function plotargrf1(req,res){
const fksensor= req.params.fksensor;


dashEstufaModel.plotargrf1(fksensor)
    .then(result=>{
        if (result.length > 0) {
                res.status(200).json(result);
            } else {
                res.status(204).send("Nenhum sensor encontrado.");
            }
    })
    .catch(erro => {
            console.error("Erro ao buscar sensores:", erro);
            res.status(500).json(erro);
        });
}

function plotargrf2(req,res){

}


module.exports={
    listarEstufas,
    listarSensores,
    sensorMinMax,
    contarAlertas,
    plotargrf1,
    plotargrf2
}