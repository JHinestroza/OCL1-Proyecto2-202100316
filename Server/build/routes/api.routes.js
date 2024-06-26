"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const api_controller_1 = __importDefault(require("../controller/api.controller"));
const express_1 = __importDefault(require("express"));
const router = express_1.default.Router();
router.get("/ping", api_controller_1.default.ping);
router.post("/parser", api_controller_1.default.parser);
//router.post("/parse", controller.parse)
exports.default = router;
