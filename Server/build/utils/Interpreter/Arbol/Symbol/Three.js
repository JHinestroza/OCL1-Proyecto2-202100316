"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.Nodo = void 0;
const SymbolTable_1 = __importDefault(require("./SymbolTable"));
// import { CDigraph, CNode, CEdge} from '../../../Graphviz'
//import { toDot } from 'ts-graphviz';
class Three {
    constructor(production) {
        this.instrucciones = production.returnInstruction;
        this.consola = '';
        this.tablaGlobal = new SymbolTable_1.default();
        this.errores = new Array();
        this.raiz = production.nodeInstruction;
        this.semanticErrors = [];
        this.graphIndex = 0;
    }
    setSemanticError(error) {
        this.semanticErrors.push(error);
    }
    getSemanticError() {
        return this.semanticErrors;
    }
    getconsola() {
        return this.consola;
    }
    setconsola(value) {
        this.consola = value;
    }
    actualizaConsola(uptodate) {
        this.consola = `${this.consola}${uptodate}\n`;
    }
    getinstrucciones() {
        return this.instrucciones;
    }
    setinstrucciones(value) {
        this.instrucciones = value;
    }
    getErrores() {
        return this.errores;
    }
    seterrores(value) {
        this.errores = value;
    }
    gettablaGlobal() {
        return this.tablaGlobal;
    }
    settablaGlobal(value) {
        this.tablaGlobal = value;
    }
    getRaiz() {
        return this.raiz;
    }
}
exports.default = Three;
class Nodo {
    constructor(valor) {
        this.valor = valor;
        this.hijos = [];
    }
    getValor() {
        return this.valor;
    }
    setValor(valor) {
        this.valor = valor;
    }
    setHijos(hijos) {
        this.hijos = hijos;
    }
    setPadre(padre) {
        this.padre = padre;
    }
    getPadre() {
        return this.padre;
    }
    getHijos() {
        return this.hijos;
    }
    generateProduction(labels) {
        labels.forEach(element => {
            (typeof element === "string" && this.hijos.push(new Nodo(element)))
                ||
                    (element instanceof Nodo && this.hijos.push(element));
        });
        return this;
    }
}
exports.Nodo = Nodo;
