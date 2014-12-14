"use strict"
express = require("express")
controller = require("./character.controller")
auth = require("../../auth/auth.service")
router = express.Router()
router.get "/", auth.hasRole("dev"), controller.index
router.get "/:id", controller.show
router.post "/", auth.hasRole("player"), controller.create
router.put "/:id", auth.hasRole("player"), controller.update
router.patch "/:id", auth.hasRole("player"), controller.update
router.delete "/:id", auth.hasRole("player"), controller.destroy
module.exports = router
