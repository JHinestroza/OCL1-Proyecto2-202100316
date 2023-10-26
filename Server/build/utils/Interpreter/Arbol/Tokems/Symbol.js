"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Symbol = void 0;
class Symbol {
    constructor(line, column, id, typeId, type, env) {
        this.line = line;
        this.column = column;
        this.id = id;
        this.typeId = typeId;
        this.type = type;
        this.env = env;
        this.n = 0;
    }
    toString() {
        return `Identificador: ${this.id}, Tipo ID: ${this.typeId}, Tipo: ${this.type}, Entorno: ${this.env}. ${this.line}:${this.column}`;
    }
    getDot() {
        return `<tr><td bgcolor="white">${this.n}</td><td bgcolor="white">${this.id}</td><td bgcolor="white">${this.typeId}</td><td bgcolor="white">${this.type}</td><td bgcolor="white">${this.env}</td><td bgcolor="white">${this.line}</td><td bgcolor="white">${this.column}</td></tr>`;
    }
}
exports.Symbol = Symbol;
