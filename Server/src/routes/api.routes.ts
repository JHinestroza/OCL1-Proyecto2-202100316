import controller from '../controller/api.controller'
import express from 'express'
const router = express.Router();

router.get("/ping", controller.ping)
router.post("/parser", controller.parser)
//router.post("/parse", controller.parse)

export default router;