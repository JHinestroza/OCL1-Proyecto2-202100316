import { Response, Request } from "express";
import Errores from '../../utils/Interpreter/Arbol/Exceptions/Error';
import Three from "../../utils/Interpreter/Arbol/Symbol/Three";
import SymbolTable from "../../utils/Interpreter/Arbol/Symbol/SymbolTable";
import { Instruccion } from "../../utils/Interpreter/Arbol/Abstract/Instruccion";
import express from 'express';


export let listaErrores: Array<Errores> = [];

export const parser = (req: Request & unknown, res: Response): void => {
  const graphviz = require('graphviz');
    listaErrores = new Array<Errores>();
    let parser = require('../../utils/Interpreter/analizador');
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
          console.log(resultador);
          ast.actualizaConsola((<Errores>resultador).returnError());
        }        
      }      
      
      const arbolGrafo = ast.getTree("ast");
      
      res.json({ consola: ast.getconsola(), grafo: arbolGrafo, errores: listaErrores, simbolos: [] });
    } catch (err) {
        console.log(err)
        res.json({ consola: '', error: err, errores: listaErrores, simbolos: [] });
    }
}
