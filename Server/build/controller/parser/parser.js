"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.parser = exports.listaErrores = void 0;
const Error_1 = __importDefault(require("../../utils/Interpreter/Arbol/Exceptions/Error"));
const Three_1 = __importDefault(require("../../utils/Interpreter/Arbol/Symbol/Three"));
const SymbolTable_1 = __importDefault(require("../../utils/Interpreter/Arbol/Symbol/SymbolTable"));
const Instruccion_1 = require("../../utils/Interpreter/Arbol/Abstract/Instruccion");
exports.listaErrores = [];
const parser = (req, res) => {
    exports.listaErrores = new Array();
    let parser = require('../../utils/Interpreter/analizador');
    //const { peticion } = req.body;
    //res.send(parser.parse(peticion.toString()))
    const { peticion } = req.body;
    try {
        const returnThree = parser.parse(peticion);
        let ast = new Three_1.default(returnThree);
        var tabla = new SymbolTable_1.default();
        ast.settablaGlobal(tabla);
        for (let i of ast.getinstrucciones()) {
            if (i instanceof Error_1.default) {
                exports.listaErrores.push(i);
                ast.actualizaConsola(i.returnError());
            }
            //console.log(i)
            var resultador = i instanceof Instruccion_1.Instruccion ? i.interpretar(ast, tabla) : new Error_1.default("ERROR SEMANTICO", "no se puede ejecutar la instruccion", 0, 0);
            if (resultador instanceof Error_1.default) {
                exports.listaErrores.push(resultador);
                ast.actualizaConsola(resultador.returnError());
            }
        }
        //const arbolGrafo = ast.getTree("ast");
        //console.log(arbolGrafo)
        res.json({ consola: ast.getconsola(), errores: exports.listaErrores, simbolos: [] });
    }
    catch (err) {
        //console.log(err)
        res.json({ consola: '', error: err, errores: exports.listaErrores, simbolos: [] });
    }
};
exports.parser = parser;
//Primera instrucucion pensada
// const app = express();
// const  texto  = JSON.stringify(req.body) ; // Suponiendo que el texto se envía en el cuerpo de la solicitud POST
// if (texto) {
//     res.send(`Recibido: ${texto}`);
//     console.log(`Texto recibido: ${texto}`);
// } else {
//     res.status(400).send('Error: No se proporcionó un texto en la solicitud.');
// }
// esto si funcio 
// try {
//     const returnThree = parser.parse(peticion)
//     let ast = new Three(returnThree);
//     var tabla = new SymbolTable();
//     ast.settablaGlobal(tabla);
//     for (let i of ast.getinstrucciones()) {
//         if (i instanceof Errores) {
//             listaErrores.push(i);
//             ast.actualizaConsola((<Errores>i).returnError());
//         }
//         console.log(i)
//         var resultador = i instanceof Instruccion ? i.interpretar(ast, tabla) : new Errores("ERROR SEMANTICO", "no se puede ejecutar la instruccion", 0, 0);
//         if (resultador instanceof Errores) {
//             listaErrores.push(resultador);
//             ast.actualizaConsola((<Errores>resultador).returnError());
//         }
//     }
//     //const arbolGrafo = ast.getTree("ast");
//     //console.log(arbolGrafo)
//     res.json({ consola: ast.getconsola(), errores: listaErrores, simbolos: [] });
// } catch (err) {
//     //console.log(err)
//     res.json({ consola: '', error: err, errores: listaErrores, simbolos: [] });
// }
