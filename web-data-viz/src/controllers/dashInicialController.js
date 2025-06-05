var dashInicialModel = require("../models/dashInicialModel");

function buscarInfoDash(req, res) {
    var fkEmp = req.body.fkEmpServer;

    dashInicialModel.buscarInfoDash(fkEmp).then((resultado) => {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(200).json([]);
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar os quizes: ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}



module.exports = {
    buscarInfoDash
}
