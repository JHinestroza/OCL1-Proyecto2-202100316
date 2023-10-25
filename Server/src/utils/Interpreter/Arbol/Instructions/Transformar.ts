import { Instruccion } from '../Abstract/Instruccion';
import Errores from '../Exceptions/Error';
import Three from '../Symbol/Three';
import SymbolTable from '../Symbol/SymbolTable';
import Type, { DataType } from '../Symbol/Type';
import { Console } from 'console';

export default class Transformar extends Instruccion {
    private cadena: Instruccion;
    private transformado: cambio;
    private cantida_redodndeo: any;

    constructor(expresion: Instruccion, cambio: cambio, redondeo: number,linea: number, columna: number) {
        super(new Type(DataType.INDEFINIDO), linea, columna);
        this.cadena = expresion;
        this.transformado = cambio;
        this.cantida_redodndeo = redondeo
    }

    public interpretar(arbol: Three, tabla: SymbolTable) {
        let valor = this.cadena.interpretar(arbol, tabla);
        if (this.transformado === cambio.LOWER) {
            valor = valor.toLowerCase()
            //console.log(valor)
            arbol.actualizaConsola(valor + '');
        } 
        else if (this.transformado === cambio.UPPER) {
            valor = valor.toUpperCase()
            //console.log(valor)
            arbol.actualizaConsola(valor + '');

        } else if (this.transformado === cambio.ROUND) {
            // console.log("cantidad de decimales" + this.cantida_redodndeo)
            // console.log("numero" + valor)
            valor = redondearA(this.cantida_redodndeo, valor);
            arbol.actualizaConsola(valor + '');

        } else if (this.transformado === cambio.LEN) {
            valor = valor.length
            //console.log(valor)
            arbol.actualizaConsola(valor + '');

        }else if (this.transformado === cambio.TypeOf) {
            const tipo = obtenerTipo(this.cadena, valor)
            arbol.actualizaConsola(tipo + '');

        }
        else if (this.transformado === cambio.TRUNCATE) {
            valor = truncarDecimales( valor,this.cantida_redodndeo);
            arbol.actualizaConsola(valor + '');

        }
    }
}
function redondearA(decimales: number, numero: number): number {
    const factor = 10 ** decimales;
    return Math.round(numero * factor) / factor;
  }

  function obtenerTipo(valor: any, tipo: any) {
    if (valor.tipoDato.getTipo() == DataType.DECIMAL){
        if (Number.isInteger(valor)){
            return "int"
        }else{
            return "double"
        }
    } else  if (valor.tipoDato.getTipo() == DataType.CADENA){ 
        return "VARCHAR"
    } else  if (valor.tipoDato.getTipo() == DataType.BOOLEAN){ 
        return "BOOLEAN"
    }
  }

  function truncarDecimales(numero: number, decimales: number): number {
    const factor = Math.pow(10, decimales);
    return Math.trunc(numero * factor) / factor;
}

export enum cambio {
    LOWER,
    UPPER,
    ROUND,
    LEN,
    TypeOf,
    TRUNCATE
}