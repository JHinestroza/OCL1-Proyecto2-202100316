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
Object.defineProperty(exports, "__esModule", { value: true });
exports.tipoOp = void 0;
const Instruccion_1 = require("../Abstract/Instruccion");
const Type_1 = __importStar(require("../Symbol/Type"));
class Aritmetico extends Instruccion_1.Instruccion {
    constructor(tipo, opIzq, opDer, fila, columna) {
        super(new Type_1.default(Type_1.DataType.INDEFINIDO), fila, columna);
        this.tipo = tipo;
        this.operacionIzq = opIzq;
        this.operacionDer = opDer;
    }
    interpretar(arbol, tabla) {
        if (this.tipo == tipoOp.SUMA) {
            let valueIzq = this.operacionIzq.interpretar(arbol, tabla);
            let valueDer = this.operacionDer.interpretar(arbol, tabla);
            if (this.operacionIzq.tipoDato.getTipo() == Type_1.DataType.DECIMAL) {
                if (this.operacionDer.tipoDato.getTipo() == Type_1.DataType.DECIMAL) {
                    this.tipoDato.setTipo(Type_1.DataType.DECIMAL);
                    console.log((valueIzq) + (valueDer));
                    return (Number(valueIzq) + Number(valueDer));
                }
                else if (this.operacionDer.tipoDato.getTipo() == Type_1.DataType.CADENA) {
                    this.tipoDato.setTipo(Type_1.DataType.CADENA);
                    return (`${valueIzq.toString()} + ${valueDer.toString()}`);
                }
            }
            if (this.operacionIzq.tipoDato.getTipo() == Type_1.DataType.CADENA) {
                if (this.operacionDer.tipoDato.getTipo() == Type_1.DataType.DECIMAL) {
                    this.tipoDato.setTipo(Type_1.DataType.DECIMAL);
                    return (`${valueIzq.toString()} ${valueDer.toString()}`);
                }
                else if (this.operacionDer.tipoDato.getTipo() == Type_1.DataType.CADENA) {
                    this.tipoDato.setTipo(Type_1.DataType.CADENA);
                    return (`${valueIzq.toString()} ${valueDer.toString()}`);
                }
            }
        }
        else if (this.tipo === tipoOp.RESTA) {
            let valueIzq = this.operacionIzq.interpretar(arbol, tabla);
            let valueDer = this.operacionDer.interpretar(arbol, tabla);
            console.log("este es el valor izquierdo" + valueIzq);
            console.log("este es el valor derecho" + valueDer);
            if (this.operacionIzq.tipoDato.getTipo() === Type_1.DataType.DECIMAL) {
                if (this.operacionDer.tipoDato.getTipo() === Type_1.DataType.DECIMAL) {
                    this.tipoDato.setTipo(Type_1.DataType.DECIMAL);
                    return (Number(valueIzq) - Number(valueDer));
                }
            }
        }
        else if (this.tipo === tipoOp.MULTIPLICACION) {
            let valueIzq = this.operacionIzq.interpretar(arbol, tabla);
            let valueDer = this.operacionDer.interpretar(arbol, tabla);
            if (this.operacionIzq.tipoDato.getTipo() === Type_1.DataType.DECIMAL) {
                if (this.operacionDer.tipoDato.getTipo() === Type_1.DataType.DECIMAL) {
                    this.tipoDato.setTipo(Type_1.DataType.DECIMAL);
                    return (Number(valueIzq) * Number(valueDer));
                }
            }
        }
        else if (this.tipo === tipoOp.DIVISION) {
            let valueIzq = this.operacionIzq.interpretar(arbol, tabla);
            let valueDer = this.operacionDer.interpretar(arbol, tabla);
            if (this.operacionIzq.tipoDato.getTipo() === Type_1.DataType.DECIMAL) {
                if (this.operacionDer.tipoDato.getTipo() === Type_1.DataType.DECIMAL) {
                    this.tipoDato.setTipo(Type_1.DataType.DECIMAL);
                    return (Number(valueIzq) / Number(valueDer));
                }
            }
        }
        else if (this.tipo === tipoOp.MOD) {
            let valueIzq = this.operacionIzq.interpretar(arbol, tabla);
            let valueDer = this.operacionDer.interpretar(arbol, tabla);
            if (this.operacionIzq.tipoDato.getTipo() === Type_1.DataType.DECIMAL) {
                if (this.operacionDer.tipoDato.getTipo() === Type_1.DataType.DECIMAL) {
                    this.tipoDato.setTipo(Type_1.DataType.DECIMAL);
                    return (Number(valueIzq) % Number(valueDer));
                }
            }
        }
        return null;
    }
}
exports.default = Aritmetico;
var tipoOp;
(function (tipoOp) {
    tipoOp[tipoOp["SUMA"] = 0] = "SUMA";
    tipoOp[tipoOp["RESTA"] = 1] = "RESTA";
    tipoOp[tipoOp["DIVISION"] = 2] = "DIVISION";
    tipoOp[tipoOp["MULTIPLICACION"] = 3] = "MULTIPLICACION";
    tipoOp[tipoOp["MOD"] = 4] = "MOD";
})(tipoOp || (exports.tipoOp = tipoOp = {}));
