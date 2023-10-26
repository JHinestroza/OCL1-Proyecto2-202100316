import { Response, Request } from "express";
import Errores from '../../utils/Interpreter/Arbol/Exceptions/Error';
import Three from "../../utils/Interpreter/Arbol/Symbol/Three";
import SymbolTable from "../../utils/Interpreter/Arbol/Symbol/SymbolTable";
import { Instruccion } from "../../utils/Interpreter/Arbol/Abstract/Instruccion";
import { printErrors } from "../../utils/Interpreter/Arbol/Exceptions/Reportes";
import * as fs from 'fs';
import { printTokems } from "../../utils/Interpreter/Arbol/Tokems/ReporteTokems";
import {consola} from "../../utils/Interpreter/Arbol/Exceptions/Reportes";
import { spawnSync } from 'child_process';
export let listaErrores: Array<Errores> = [];



export const parser = (req: Request & unknown, res: Response): void => {
  const graphviz = require('graphviz'); 
    listaErrores = new Array<Errores>();
    consola.splice(0, consola.length);
    let parser = require('../../utils/Interpreter/analizador');
    const { peticion } = req.body;

    try { 
      const returnThree = parser.parse(peticion)
      let ast = new Three(returnThree);
      var tabla = new SymbolTable();
      ast.settablaGlobal(tabla);

      consola.forEach((error) => {
        ast.actualizaConsola((error.toString()+ ''));
      });

      for (let i of ast.getinstrucciones()) {
        if (i instanceof Errores) {
          listaErrores.push(i);
        
          ast.actualizaConsola((<Errores>i).returnError());
        }
        //console.log(i)
        var resultador = i instanceof Instruccion ? i.interpretar(ast, tabla) : new Errores("ERROR SEMANTICO", "no se puede ejecutar la instruccion", 0, 0);
        if (resultador instanceof Errores) {
          listaErrores.push(resultador);
          console.log(resultador);
          ast.actualizaConsola((<Errores>resultador).returnError());
        }        
      }      
      
      
      const arbolGrafo = ast.getTree("ast");
      console.log("este es el tamano de errores"+ consola.length)
      const reportes_errores = printErrors.getDot()
      Graficar(printTokems.getDot());
      GraficarErrores(reportes_errores)
      res.json({ consola: ast.getconsola(), grafo: arbolGrafo, errores: listaErrores, simbolos: [] });
    } catch (err) {
        console.log(err)
        res.json({ consola: '', error: err, errores: listaErrores, simbolos: [] });
    }
}

function GraficarErrores(texto: string){
  
      fs.writeFileSync('Errores.dot', texto, 'utf8');
      // Generar el archivo PNG utilizando Graphviz
      spawnSync('dot', ['-Tpng', 'Errores.dot', '-o', 'Errores.png']);
}

function Graficar(texto: string){
  
  fs.writeFileSync('Tokems.dot', texto, 'utf8');
  // Generar el archivo PNG utilizando Graphviz
  spawnSync('dot', ['-Tpng', 'Tokems.dot', '-o', 'Tokems.png']);
}