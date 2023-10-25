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
exports.cambio = void 0;
const Instruccion_1 = require("../Abstract/Instruccion");
const Type_1 = __importStar(require("../Symbol/Type"));
class Transformar extends Instruccion_1.Instruccion {
    constructor(expresion, cambio, redondeo, linea, columna) {
        super(new Type_1.default(Type_1.DataType.INDEFINIDO), linea, columna);
        this.cadena = expresion;
        this.transformado = cambio;
        this.cantida_redodndeo = redondeo;
    }
    interpretar(arbol, tabla) {
        let valor = this.cadena.interpretar(arbol, tabla);
        if (this.transformado === cambio.LOWER) {
            valor = valor.toLowerCase();
            //console.log(valor)
            arbol.actualizaConsola(valor + '');
        }
        else if (this.transformado === cambio.UPPER) {
            valor = valor.toUpperCase();
            //console.log(valor)
            arbol.actualizaConsola(valor + '');
        }
        else if (this.transformado === cambio.ROUND) {
            // console.log("cantidad de decimales" + this.cantida_redodndeo)
            // console.log("numero" + valor)
            valor = redondearA(this.cantida_redodndeo, valor);
            arbol.actualizaConsola(valor + '');
        }
        else if (this.transformado === cambio.LEN) {
            valor = valor.length;
            //console.log(valor)
            arbol.actualizaConsola(valor + '');
        }
        else if (this.transformado === cambio.TypeOf) {
            const tipo = obtenerTipo(this.cadena, valor);
            arbol.actualizaConsola(tipo + '');
        }
        else if (this.transformado === cambio.TRUNCATE) {
            valor = truncarDecimales(valor, this.cantida_redodndeo);
            arbol.actualizaConsola(valor + '');
        }
    }
}
exports.default = Transformar;
function redondearA(decimales, numero) {
    const factor = 10 ** decimales;
    return Math.round(numero * factor) / factor;
}
function obtenerTipo(valor, tipo) {
    if (valor.tipoDato.getTipo() == Type_1.DataType.DECIMAL) {
        if (Number.isInteger(valor)) {
            return "int";
        }
        else {
            return "double";
        }
    }
    else if (valor.tipoDato.getTipo() == Type_1.DataType.CADENA) {
        return "VARCHAR";
    }
    else if (valor.tipoDato.getTipo() == Type_1.DataType.BOOLEAN) {
        return "BOOLEAN";
    }
}
function truncarDecimales(numero, decimales) {
    const factor = Math.pow(10, decimales);
    return Math.trunc(numero * factor) / factor;
}
var cambio;
(function (cambio) {
    cambio[cambio["LOWER"] = 0] = "LOWER";
    cambio[cambio["UPPER"] = 1] = "UPPER";
    cambio[cambio["ROUND"] = 2] = "ROUND";
    cambio[cambio["LEN"] = 3] = "LEN";
    cambio[cambio["TypeOf"] = 4] = "TypeOf";
    cambio[cambio["TRUNCATE"] = 5] = "TRUNCATE";
})(cambio || (exports.cambio = cambio = {}));
