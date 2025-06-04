var alertasModel = require("../models/alertasModel");

function buscarAlertas(req, res) {
    var fkEmp = req.params.fkEmp;

    alertasModel.buscarAlertas(fkEmp).then((resultado) => {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(200).json([]);
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar o alerta: ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

module.exports = {
    buscarAlertas
}
