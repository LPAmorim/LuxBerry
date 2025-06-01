var historicoModel = require("../models/historicoModel");

function listarEstufas(req, res) {
    const fkempresa = req.params.fkempresa;

    historicoModel.listarEstufas(fkempresa)
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

function puxarHistoricoInteiro(req, res){
    const fkempresa = req.params.fkempresa;

    historicoModel.puxarHistoricoInteiro(fkempresa)
        .then(result => {
            if (result.length > 0) {
                res.status(200).json(result);
            } else {
                res.status(204).send("Nenhum alerta encontrado.");
            }
        })
        .catch(erro => {
            console.error("Erro ao buscar alertas:", erro);
            res.status(500).json(erro);
        });
}

function puxarHistoricoPorEstufa(req, res){
    const fkEstufa = req.params.fkEstufa;

    historicoModel.puxarHistoricoPorEstufa(fkEstufa)
        .then(result => {
            if (result.length > 0) {
                res.status(200).json(result);
            } else {
                res.status(204).send("Nenhum alerta encontrado.");
            }
        })
        .catch(erro => {
            console.error("Erro ao buscar alertas:", erro);
            res.status(500).json(erro);
        });
}


module.exports={
    listarEstufas,
    puxarHistoricoInteiro,
    puxarHistoricoPorEstufa
}