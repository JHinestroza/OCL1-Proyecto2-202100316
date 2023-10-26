
export class Tokems {
    public n: number = 0
    constructor(public line: number, public column: number, public type: TypeTokem, public description: string) { }
    public toString(): string {
        return `→ Tokem ${this.type}, ${this.description}. fila: ${this.line}   columna: ${this.column}`
    }
    public getDot(): string {
        return `<tr><td bgcolor="white">${this.n}</td><td bgcolor="white">${this.type}</td><td bgcolor="white">${this.description}</td><td bgcolor="white">${this.line}</td><td bgcolor="white">${this.column}</td></tr>`
    }

}
export enum TypeTokem {
    TOKEMS = "TOKEM",
}
