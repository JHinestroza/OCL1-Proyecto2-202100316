import { Response, Request } from "express";
import Errores from '../../utils/Interpreter/Arbol/Exceptions/Error';
import Three from "../../utils/Interpreter/Arbol/Symbol/Three";
import SymbolTable from "../../utils/Interpreter/Arbol/Symbol/SymbolTable";
 import { Instruccion } from "../../utils/Interpreter/Arbol/Abstract/Instruccion";
import express from 'express';



export let listaErrores: Array<Errores> = [];

export const parser = (req: Request & unknown, res: Response): void => {
    listaErrores = new Array<Errores>();
    let parser = require('../../utils/Interpreter/analizador');
    //const { peticion } = req.body;
    //res.send(parser.parse(peticion.toString()))
    const { peticion } = req.body;

    try { 
      const returnThree = parser.parse(peticion)
      let ast = new Three(returnThree);
      var tabla = new SymbolTable();
      ast.settablaGlobal(tabla);
      for (let i of ast.getinstrucciones()) {
        if (i instanceof Errores) {
          listaErrores.push(i);
          ast.actualizaConsola((<Errores>i).returnError());
        }
        //console.log(i)
        var resultador = i instanceof Instruccion ? i.interpretar(ast, tabla) : new Errores("ERROR SEMANTICO", "no se puede ejecutar la instruccion", 0, 0);
        if (resultador instanceof Errores) {
          listaErrores.push(resultador);
          ast.actualizaConsola((<Errores>resultador).returnError());
        }        
      }      
      //const arbolGrafo = ast.getTree("ast");
      //console.log(arbolGrafo)
      res.json({ consola: ast.getconsola(), errores: listaErrores, simbolos: [] });
    } catch (err) {
        //console.log(err)
        res.json({ consola: '', error: err, errores: listaErrores, simbolos: [] });
    }
    
};



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