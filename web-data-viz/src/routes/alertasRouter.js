var express = require("express");
var router = express.Router();

var alertasController = require("../controllers/alertasController");
router.get("/buscarAlertas/:fkEmp", function (req, res) {
    alertasController.buscarAlertas(req, res);
})

module.exports = router;