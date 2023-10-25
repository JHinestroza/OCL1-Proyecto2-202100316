"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.Nodo = void 0;
const SymbolTable_1 = __importDefault(require("./SymbolTable"));
const Graphviz_1 = require("../../../Graphviz");
const ts_graphviz_1 = require("ts-graphviz");
const fs = __importStar(require("fs"));
const child_process_1 = require("child_process");
class Three {
    constructor(production) {
        this.instrucciones = production.retorno;
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
    buildTree(padre, nodoPadre, digraph) {
        const nodos = padre.getHijos();
        for (let i = 0; i < nodos.length; i++) {
            const nodo = nodos[i];
            const node = new Graphviz_1.CNode(this.graphIndex++, nodo.getValor());
            digraph.addNode(node);
            const edge = new Graphviz_1.CEdge([nodoPadre, node], "");
            digraph.addEdge(edge);
            this.buildTree(nodo, node, digraph);
        }
    }
    getTree(name) {
        const digraph = new Graphviz_1.CDigraph(name);
        const actual = this.raiz;
        const node = new Graphviz_1.CNode(this.graphIndex++, actual.getValor());
        digraph.addNode(node);
        this.buildTree(actual, node, digraph);
        this.graphIndex = 0;
        const dot = (0, ts_graphviz_1.toDot)(digraph);
        fs.writeFileSync('AST.dot', dot, 'utf8');
        // Generar el archivo PNG utilizando Graphviz
        (0, child_process_1.spawnSync)('dot', ['-Tpng', 'AST.dot', '-o', 'AST.png']);
        console.log('Archivo PNG generado: grafo.png');
        return (0, ts_graphviz_1.toDot)(digraph);
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
