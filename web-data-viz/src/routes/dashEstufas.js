var express = require("express");
var router = express.Router();

var dashEstufaController = require("../controllers/dashEstufaController")

router.get("/estufa/:fkempresa", function(req,res){
    dashEstufaController.listarEstufas(req,res)
})
router.get("/sensor/:fkEstufa", function(req,res){
    dashEstufaController.listarSensores(req,res)
})

router.get("/grafico/:fksensor",function(req,res) {
    dashEstufaController.plotargrf1(req,res)
})

router.get("/graficoMedia", function(req,res){
    dashEstufaController.plotargrf2(req,res)
})

router.get("/sensorMinMax/:fksensor", function(req,res){
    dashEstufaController.sensorMinMax(req,res)
})
module.exports = router;
