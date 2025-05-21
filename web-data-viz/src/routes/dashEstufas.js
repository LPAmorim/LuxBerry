var express = require("express");
var router = express.Router();

var dashEstufaController = require("../controllers/dashEstufaController")

router.get("/estufa/:fkempresa", function(req,res){
    dashEstufaController.listarEstufas(req,res)
})
router.get("/sensor/:fkEstufa", function(req,res){
    dashEstufaController.listarSensores(req,res)
})

module.exports = router;
