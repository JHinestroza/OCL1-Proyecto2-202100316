import { Errores } from "./Errores"
import { Symbol } from "./Symbol"
export let consola: Array<Errores> = []
class ErroresTable {
    
    private ErroresTable: Array<Errores> = []
    public splice() {
        this.ErroresTable.splice(0,this.ErroresTable.length)
    }
    public push(value: Errores) {
        value.n = this.ErroresTable.length + 1
        this.ErroresTable.push(value)
    }
    public get(): string {
        return this.ErroresTable.map((symbol) => symbol.toString()).join('\n')
    }
    public getDot(): string {
        return `digraph Erroress {node[shape=none fontname="Arial"];label="Erroreses";table[label=<<table border="0" cellborder="1" cellspacing="0" cellpadding="3"><tr><td bgcolor="#009900" width="100"><font color="#FFFFFF">No.</font></td><td bgcolor="#009900" width="100"><font color="#FFFFFF">Tipo</font></td><td bgcolor="#009900" width="100"><font color="#FFFFFF">Descripción</font></td><td bgcolor="#009900" width="100"><font color="#FFFFFF">Línea</font></td><td bgcolor="#009900" width="100"><font color="#FFFFFF">Columna</font></td></tr> ${this.ErroresTable.map((symbol) => symbol.getDot()).join('\n')}</table>>];}`
    }
    public length(): number {
        return this.ErroresTable.length
    }
}
export let printErrors: ErroresTable = new ErroresTable()
class SymbolTable {
    private symbolTable: Array<Symbol> = []
    public splice() {
        this.symbolTable.splice(0,this.symbolTable.length)
    }
    public push(value: Symbol) {
        if(!this.symbolTable.some(
            (symbol) => symbol.id === value.id && symbol.typeId === value.typeId && symbol.type === value.type && symbol.env === value.env)
        ) {
            value.n = this.symbolTable.length + 1
            this.symbolTable.push(value)
        }
    }
    public get(): string {
        return this.symbolTable.map((symbol) => symbol.toString()).join('\n')
    }
    public getDot(): string {
        return `digraph SymbolsTable {graph[fontname="Arial" labelloc="t" bgcolor="#252526" fontcolor="white"];node[shape=none fontname="Arial"];label="Tabla de Símbolos";table[label=<<table border="0" cellborder="1" cellspacing="0" cellpadding="3"><tr><td bgcolor="#009900" width="100"><font color="#FFFFFF">No.</font></td><td bgcolor="#009900" width="100"><font color="#FFFFFF">Identificador</font></td><td bgcolor="#009900" width="100"><font color="#FFFFFF">Tipo</font></td><td bgcolor="#009900" width="100"><font color="#FFFFFF">Tipo de Dato</font></td><td bgcolor="#009900" width="100"><font color="#FFFFFF">Entorno</font></td><td bgcolor="#009900" width="100"><font color="#FFFFFF">Línea</font></td><td bgcolor="#009900" width="100"><font color="#FFFFFF">Columna</font></td></tr>${this.symbolTable.map((symbol) => symbol.getDot()).join('\n')}</table>>];}`
    }
}
export let symbolTable: SymbolTable = new SymbolTable()