var express = require("express");
var router = express.Router();

var bobController = require("../controllers/bobController");

router.post("/perguntar", bobController.perguntar);

module.exports = router;
