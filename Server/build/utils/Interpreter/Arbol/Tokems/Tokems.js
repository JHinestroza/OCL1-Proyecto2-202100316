"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.TypeTokem = exports.Tokems = void 0;
class Tokems {
    constructor(line, column, type, description) {
        this.line = line;
        this.column = column;
        this.type = type;
        this.description = description;
        this.n = 0;
    }
    toString() {
        return `→ Tokem ${this.type}, ${this.description}. fila: ${this.line}   columna: ${this.column}`;
    }
    getDot() {
        return `<tr><td bgcolor="white">${this.n}</td><td bgcolor="white">${this.type}</td><td bgcolor="white">${this.description}</td><td bgcolor="white">${this.line}</td><td bgcolor="white">${this.column}</td></tr>`;
    }
}
exports.Tokems = Tokems;
var TypeTokem;
(function (TypeTokem) {
    TypeTokem["TOKEMS"] = "TOKEM";
})(TypeTokem || (exports.TypeTokem = TypeTokem = {}));
