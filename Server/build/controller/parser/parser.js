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
exports.parser = exports.listaErrores = void 0;
const Error_1 = __importDefault(require("../../utils/Interpreter/Arbol/Exceptions/Error"));
const Three_1 = __importDefault(require("../../utils/Interpreter/Arbol/Symbol/Three"));
const SymbolTable_1 = __importDefault(require("../../utils/Interpreter/Arbol/Symbol/SymbolTable"));
const Instruccion_1 = require("../../utils/Interpreter/Arbol/Abstract/Instruccion");
const Reportes_1 = require("../../utils/Interpreter/Arbol/Exceptions/Reportes");
const fs = __importStar(require("fs"));
const ReporteTokems_1 = require("../../utils/Interpreter/Arbol/Tokems/ReporteTokems");
const Reportes_2 = require("../../utils/Interpreter/Arbol/Exceptions/Reportes");
const child_process_1 = require("child_process");
exports.listaErrores = [];
const parser = (req, res) => {
    const graphviz = require('graphviz');
    exports.listaErrores = new Array();
    Reportes_2.consola.splice(0, Reportes_2.consola.length);
    let parser = require('../../utils/Interpreter/analizador');
    const { peticion } = req.body;
    try {
        const returnThree = parser.parse(peticion);
        let ast = new Three_1.default(returnThree);
        var tabla = new SymbolTable_1.default();
        ast.settablaGlobal(tabla);
        Reportes_2.consola.forEach((error) => {
            ast.actualizaConsola((error.toString() + ''));
        });
        for (let i of ast.getinstrucciones()) {
            if (i instanceof Error_1.default) {
                exports.listaErrores.push(i);
                ast.actualizaConsola(i.returnError());
            }
            //console.log(i)
            var resultador = i instanceof Instruccion_1.Instruccion ? i.interpretar(ast, tabla) : new Error_1.default("ERROR SEMANTICO", "no se puede ejecutar la instruccion", 0, 0);
            if (resultador instanceof Error_1.default) {
                exports.listaErrores.push(resultador);
                console.log(resultador);
                ast.actualizaConsola(resultador.returnError());
            }
        }
        const arbolGrafo = ast.getTree("ast");
        console.log("este es el tamano de errores" + Reportes_2.consola.length);
        const reportes_errores = Reportes_1.printErrors.getDot();
        Graficar(ReporteTokems_1.printTokems.getDot());
        GraficarErrores(reportes_errores);
        res.json({ consola: ast.getconsola(), grafo: arbolGrafo, errores: exports.listaErrores, simbolos: [] });
    }
    catch (err) {
        console.log(err);
        res.json({ consola: '', error: err, errores: exports.listaErrores, simbolos: [] });
    }
};
exports.parser = parser;
function GraficarErrores(texto) {
    fs.writeFileSync('Errores.dot', texto, 'utf8');
    // Generar el archivo PNG utilizando Graphviz
    (0, child_process_1.spawnSync)('dot', ['-Tpng', 'Errores.dot', '-o', 'Errores.png']);
}
function Graficar(texto) {
    fs.writeFileSync('Tokems.dot', texto, 'utf8');
    // Generar el archivo PNG utilizando Graphviz
    (0, child_process_1.spawnSync)('dot', ['-Tpng', 'Tokems.dot', '-o', 'Tokems.png']);
}
