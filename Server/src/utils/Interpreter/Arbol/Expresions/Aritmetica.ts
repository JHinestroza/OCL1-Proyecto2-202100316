import { Instruccion } from '../Abstract/Instruccion';
import Arbol from '../Symbol/Three';
import tablaSimbolo from '../Symbol/SymbolTable';
import Tipo, { DataType } from '../Symbol/Type';

export default class Aritmetico extends Instruccion {
    operacionIzq: Instruccion;
    operacionDer: Instruccion;
    tipo: tipoOp;


    constructor(tipo: tipoOp, opIzq: Instruccion, opDer: Instruccion, fila: number, columna: number) {
        super(new Tipo(DataType.INDEFINIDO), fila, columna);
        this.tipo = tipo;
        this.operacionIzq = opIzq;
        this.operacionDer = opDer;
    }

    interpretar(arbol: Arbol, tabla: tablaSimbolo) {
        if (this.tipo == tipoOp.SUMA) {
            let valueIzq = this.operacionIzq.interpretar(arbol, tabla);
            let valueDer = this.operacionDer.interpretar(arbol, tabla);
            
            if (this.operacionIzq.tipoDato.getTipo() == DataType.DECIMAL) {
                if (this.operacionDer.tipoDato.getTipo() == DataType.DECIMAL) {
                    this.tipoDato.setTipo(DataType.DECIMAL);
                    console.log((valueIzq) + (valueDer))
                    return (Number(valueIzq) + Number(valueDer));
                } else if (this.operacionDer.tipoDato.getTipo() == DataType.CADENA) {
                    this.tipoDato.setTipo(DataType.CADENA);
                    return (`${valueIzq.toString()} + ${valueDer.toString()}`);
                } 
            }if (this.operacionIzq.tipoDato.getTipo() == DataType.CADENA) {
                if (this.operacionDer.tipoDato.getTipo() == DataType.DECIMAL) {
                    this.tipoDato.setTipo(DataType.DECIMAL);
                     return (`${valueIzq.toString()} ${valueDer.toString()}`);
                } else if (this.operacionDer.tipoDato.getTipo() == DataType.CADENA) {
                    this.tipoDato.setTipo(DataType.CADENA);
                    return (`${valueIzq.toString()} ${valueDer.toString()}`);
                }
            }



        } else if (this.tipo === tipoOp.RESTA) {
            let valueIzq = this.operacionIzq.interpretar(arbol, tabla);
            let valueDer = this.operacionDer.interpretar(arbol, tabla);
            console.log("este es el valor izquierdo" + valueIzq);
            console.log("este es el valor derecho" + valueDer);
            if (this.operacionIzq.tipoDato.getTipo() === DataType.DECIMAL) {
                if (this.operacionDer.tipoDato.getTipo() === DataType.DECIMAL) {
                    this.tipoDato.setTipo(DataType.DECIMAL);
                    return (Number(valueIzq) - Number(valueDer));
                }
            }
        } else if (this.tipo === tipoOp.MULTIPLICACION) {
            let valueIzq = this.operacionIzq.interpretar(arbol, tabla);
            let valueDer = this.operacionDer.interpretar(arbol, tabla);
            if (this.operacionIzq.tipoDato.getTipo() === DataType.DECIMAL) {
                if (this.operacionDer.tipoDato.getTipo() === DataType.DECIMAL) {
                    this.tipoDato.setTipo(DataType.DECIMAL);
                    return (Number(valueIzq) * Number(valueDer));
                }
            }
        } else if (this.tipo === tipoOp.DIVISION) {
            let valueIzq = this.operacionIzq.interpretar(arbol, tabla);
            let valueDer = this.operacionDer.interpretar(arbol, tabla);
            if (this.operacionIzq.tipoDato.getTipo() === DataType.DECIMAL) {
                if (this.operacionDer.tipoDato.getTipo() === DataType.DECIMAL) {
                    this.tipoDato.setTipo(DataType.DECIMAL);
                    return (Number(valueIzq)  / Number(valueDer));
                }
            }
        }else if (this.tipo === tipoOp.MOD) {
            let valueIzq = this.operacionIzq.interpretar(arbol, tabla);
            let valueDer = this.operacionDer.interpretar(arbol, tabla);
            if (this.operacionIzq.tipoDato.getTipo() === DataType.DECIMAL) {
                if (this.operacionDer.tipoDato.getTipo() === DataType.DECIMAL) {
                    this.tipoDato.setTipo(DataType.DECIMAL);
                    return (Number(valueIzq)  % Number(valueDer));
                }
            }
        }
        return null;
    }
}

export enum tipoOp {
    SUMA,
    RESTA,
    DIVISION,
    MULTIPLICACION,
    MOD
}