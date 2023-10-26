"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.TypeError = exports.Errores = void 0;
class Errores {
    constructor(line, column, type, description) {
        this.line = line;
        this.column = column;
        this.type = type;
        this.description = description;
        this.n = 0;
    }
    toString() {
        return `→ Error ${this.type}, ${this.description}. fila: ${this.line}   columna: ${this.column}`;
    }
    getDot() {
        return `<tr><td bgcolor="white">${this.n}</td><td bgcolor="white">${this.type}</td><td bgcolor="white">${this.description}</td><td bgcolor="white">${this.line}</td><td bgcolor="white">${this.column}</td></tr>`;
    }
}
exports.Errores = Errores;
var TypeError;
(function (TypeError) {
    TypeError["LEXICO"] = "LEXICO";
    TypeError["SIN"] = "SINTACTICO";
})(TypeError || (exports.TypeError = TypeError = {}));
