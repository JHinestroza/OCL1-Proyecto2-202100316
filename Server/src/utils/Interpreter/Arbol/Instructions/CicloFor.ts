import { Instruccion } from '../Abstract/Instruccion';
import Arbol from '../Symbol/Three';
import tablaSimbolo from '../Symbol/SymbolTable';
import Tipo, {DataType} from '../Symbol/Type';
import SymbolTable from '../Symbol/SymbolTable';
import cloneDeep from 'lodash/cloneDeep';

export default class CicloFor extends Instruccion {
    private Ran1: Instruccion;
    private Ran2: Instruccion;
    private listaInstrucciones: Instruccion [];    

    constructor(
        Ran1: Instruccion, 
        Ran2: Instruccion,
        listaInstrucciones: Instruccion[], 
        linea: number, 
        columna: number
    ){
        super(new Tipo(DataType.INDEFINIDO), linea, columna);
        this.Ran1 = Ran1
        this.Ran2 = Ran2
        this.listaInstrucciones = listaInstrucciones
    }
    public interpretar(arbol: Arbol, tabla: tablaSimbolo) {
        const tablaLocal = new SymbolTable(tabla)
        let valueIzq = Number(this.Ran1.interpretar(arbol, tabla));
        let valueDer = Number(this.Ran2.interpretar(arbol, tabla));
        console.log("este es el rango  " + valueIzq )
        console.log("este es el rango  " + valueDer )
        if (valueIzq < valueDer){
            while( valueIzq != valueDer){   
                const instructionsToExec = cloneDeep(this.listaInstrucciones)    
                for(let i of instructionsToExec){
                    i.interpretar(arbol, tablaLocal)
                }
                valueIzq +=1
                //console.log("por aqui voy "+valueIzq)
            }
        }
        return null;
    }
}
