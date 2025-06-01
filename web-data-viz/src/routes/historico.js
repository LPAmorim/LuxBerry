var express = require("express");
var router = express.Router();

var historicoController = require("../controllers/historicoController")

router.get("/estufa/:fkempresa", function(req,res){
    historicoController.listarEstufas(req,res)
})

router.get("/alertas/empresa/:fkempresa",function(req,res) {
    historicoController.puxarHistoricoInteiro(req,res)
})

router.get("/alertas/estufa/:fkEstufa", function (req, res) {
    historicoController.puxarHistoricoPorEstufa(req, res);
});


module.exports = router;