"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.symbolTable = exports.printTokems = void 0;
class TokemTable {
    constructor() {
        this.TokemTable = [];
    }
    splice() {
        this.TokemTable.splice(0, this.TokemTable.length);
    }
    push(value) {
        value.n = this.TokemTable.length + 1;
        this.TokemTable.push(value);
    }
    get() {
        return this.TokemTable.map((symbol) => symbol.toString()).join('\n');
    }
    getDot() {
        return `digraph Tokems {node[shape=none fontname="Arial"];label="Erroreses";table[label=<<table border="0" cellborder="1" cellspacing="0" cellpadding="3"><tr><td bgcolor="#009900" width="100"><font color="#FFFFFF">No.</font></td><td bgcolor="#009900" width="100"><font color="#FFFFFF">Tipo</font></td><td bgcolor="#009900" width="100"><font color="#FFFFFF">Descripción</font></td><td bgcolor="#009900" width="100"><font color="#FFFFFF">Línea</font></td><td bgcolor="#009900" width="100"><font color="#FFFFFF">Columna</font></td></tr> ${this.TokemTable.map((symbol) => symbol.getDot()).join('\n')}</table>>];}`;
    }
    length() {
        return this.TokemTable.length;
    }
}
exports.printTokems = new TokemTable();
class SymbolTable {
    constructor() {
        this.symbolTable = [];
    }
    splice() {
        this.symbolTable.splice(0, this.symbolTable.length);
    }
    push(value) {
        if (!this.symbolTable.some((symbol) => symbol.id === value.id && symbol.typeId === value.typeId && symbol.type === value.type && symbol.env === value.env)) {
            value.n = this.symbolTable.length + 1;
            this.symbolTable.push(value);
        }
    }
    get() {
        return this.symbolTable.map((symbol) => symbol.toString()).join('\n');
    }
    getDot() {
        return `digraph SymbolsTable {graph[fontname="Arial" labelloc="t" bgcolor="#252526" fontcolor="white"];node[shape=none fontname="Arial"];label="Tabla de Símbolos";table[label=<<table border="0" cellborder="1" cellspacing="0" cellpadding="3"><tr><td bgcolor="#009900" width="100"><font color="#FFFFFF">No.</font></td><td bgcolor="#009900" width="100"><font color="#FFFFFF">Identificador</font></td><td bgcolor="#009900" width="100"><font color="#FFFFFF">Tipo</font></td><td bgcolor="#009900" width="100"><font color="#FFFFFF">Tipo de Dato</font></td><td bgcolor="#009900" width="100"><font color="#FFFFFF">Entorno</font></td><td bgcolor="#009900" width="100"><font color="#FFFFFF">Línea</font></td><td bgcolor="#009900" width="100"><font color="#FFFFFF">Columna</font></td></tr>${this.symbolTable.map((symbol) => symbol.getDot()).join('\n')}</table>>];}`;
    }
}
exports.symbolTable = new SymbolTable();
