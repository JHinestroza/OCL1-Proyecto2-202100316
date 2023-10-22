"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const dotenv_1 = __importDefault(require("dotenv"));
const environments_1 = require("./utils/environments");
const apps_1 = __importDefault(require("./apps"));
dotenv_1.default.config();
(0, apps_1.default)()
    .then((app) => {
    app.listen(environments_1.PORT, () => {
        console.log(`Server Ready on PORT ${environments_1.PORT} ${process.env.NODE_ENV}`);
    });
})
    .catch((err) => console.log(err));
