var express = require("express");
var router = express.Router();

var dashInicialController = require("../controllers/dashInicialController");

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/buscarInfoDash", function (req, res) {
    dashInicialController.buscarInfoDash(req, res);
})


module.exports = router;
