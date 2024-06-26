import { Instruccion } from '../Abstract/Instruccion';
import Errores from '../Exceptions/Error';
import tablaSimbolo from './SymbolTable';
import { CDigraph, CNode, CEdge} from '../../../Graphviz'
import { toDot } from 'ts-graphviz';
import * as fs from 'fs';
import { spawnSync } from 'child_process';

export default class Three {
  private instrucciones: Array<Instruccion>;
  private errores: Array<Errores>;
  private consola: String;
  private tablaGlobal: tablaSimbolo;
  private semanticErrors: any[];
  private raiz: Nodo;
  private graphIndex: number;
  constructor(production: any) {
    this.instrucciones = production.retorno;
    this.consola = '';
    this.tablaGlobal = new tablaSimbolo();
    this.errores = new Array<Errores>();
    this.raiz = production.nodeInstruction;
    this.semanticErrors = [];
    this.graphIndex = 0;
  }
  public setSemanticError(error: string){
    this.semanticErrors.push(error)
  }
  public getSemanticError(){
    return this.semanticErrors;
  }
  public getconsola(): String {
    return this.consola;
  }
  public setconsola(value: String) {
    this.consola = value;
  }
  public actualizaConsola(uptodate: String) {
    this.consola = `${this.consola}${uptodate}\n`;
  }
  public getinstrucciones(): Array<Instruccion> {
    return this.instrucciones;
  }
  public setinstrucciones(value: Array<Instruccion>) {
    this.instrucciones = value;
  }
  public getErrores(): Array<Errores> {
    return this.errores;
  }
  public seterrores(value: Array<Errores>) {
    this.errores = value;
  }
  public gettablaGlobal(): tablaSimbolo {
    return this.tablaGlobal;
  }
  public settablaGlobal(value: tablaSimbolo) {
    this.tablaGlobal = value;
  }
  public getRaiz() {
    return this.raiz;
  }
  public buildTree(padre: Nodo, nodoPadre: CNode, digraph: CDigraph){
    const nodos = padre.getHijos()
    for(let i=0; i<nodos.length; i++){
        const nodo = nodos[i];
        const node = new CNode(this.graphIndex++, nodo.getValor());
       
        digraph.addNode(node);
        const edge = new CEdge([nodoPadre, node], "");
        digraph.addEdge(edge);

        this.buildTree(nodo, node, digraph)
    }
  }

  public getTree(name: string){
      const digraph = new CDigraph(name);
      const actual = this.raiz;

      const node = new CNode(this.graphIndex++, actual.getValor());
      digraph.addNode(node);

      this.buildTree(actual, node, digraph);
      this.graphIndex = 0;
      const dot = toDot(digraph);
      
      fs.writeFileSync('AST.dot', dot, 'utf8');
      // Generar el archivo PNG utilizando Graphviz
      spawnSync('dot', ['-Tpng', 'AST.dot', '-o', 'AST.png']);

console.log('Archivo PNG generado: grafo.png');

      return toDot(digraph)
  }

}

export class Nodo {
    private hijos: Nodo [];
    private padre: Nodo | undefined;
    private valor: any;

    constructor(valor: any) {
        this.valor = valor;
        this.hijos = [];
    }

    public getValor(): any {
        return this.valor;
    }

    public setValor(valor: any) {
        this.valor = valor;
    }

    public setHijos(hijos: Nodo[]) {
        this.hijos = hijos;
    }

    public setPadre(padre: Nodo) {
        this.padre = padre;
    }

    public getPadre(): Nodo | undefined {
        return this.padre;
    }

    public getHijos(): Nodo[] {
        return this.hijos;
    }

    public generateProduction(labels: any[]): Nodo {
        labels.forEach(element => {
            (typeof element === "string" && this.hijos.push(new Nodo(element)))
            ||
            (element instanceof Nodo && this.hijos.push(element))
        });
        return this;
    }
}