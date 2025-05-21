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
    plotargrf1,
    plotargrf2
}