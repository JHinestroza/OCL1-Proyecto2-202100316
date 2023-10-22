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
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const Instruccion_1 = require("../Abstract/Instruccion");
const Type_1 = __importStar(require("../Symbol/Type"));
const SymbolTable_1 = __importDefault(require("../Symbol/SymbolTable"));
const ReturnIns_1 = __importDefault(require("../Expresions/ReturnIns"));
class If extends Instruccion_1.Instruccion {
    constructor(operacion, listaInstrucciones, listaElseIf, listaInsElse, linea, columna) {
        super(new Type_1.default(Type_1.DataType.INDEFINIDO), linea, columna);
        this.operacionIf = operacion;
        this.listaInstrucciones = listaInstrucciones;
        this.listaElseIf = listaElseIf;
        this.listaInsElse = listaInsElse;
    }
    interpretar(arbol, tabla) {
        const condition = this.operacionIf.interpretar(arbol, tabla);
        if ((condition)) {
            const tablaLocal = new SymbolTable_1.default(tabla);
            for (let i of this.listaInstrucciones) {
                if (i instanceof ReturnIns_1.default) {
                    return i;
                }
                i.interpretar(arbol, tablaLocal);
            }
            return true;
        }
        else {
            if (this.listaElseIf) {
                for (let i of this.listaElseIf) {
                    const operation = i.interpretar(arbol, tabla);
                    if (operation) {
                        return false;
                    }
                }
            }
            if (this.listaInsElse) {
                const tablaLocal = new SymbolTable_1.default(tabla);
                for (let i of this.listaInsElse) {
                    i.interpretar(arbol, tablaLocal);
                }
                return false;
            }
        }
    }
}
exports.default = If;
