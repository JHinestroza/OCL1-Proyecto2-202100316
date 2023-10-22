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
const SymbolTable_1 = __importDefault(require("../Symbol/SymbolTable"));
const Type_1 = __importStar(require("../Symbol/Type"));
const get_1 = __importDefault(require("lodash/get"));
const cloneDeep_1 = __importDefault(require("lodash/cloneDeep"));
const ReturnIns_1 = __importDefault(require("../Expresions/ReturnIns"));
class ProcedureExec extends Instruccion_1.Instruccion {
    constructor(id, execParams, linea, columna) {
        super(new Type_1.default(Type_1.DataType.INDEFINIDO), linea, columna);
        this.id = id;
        this.execParams = execParams;
    }
    getexecParams() {
        return this.execParams;
    }
    getId() {
        return this.id;
    }
    interpretar(arbol, tabla) {
        const value = tabla.getValor(this.id);
        this.tipoDato = (0, get_1.default)(value, 'tipo', new Type_1.default(Type_1.DataType.INDEFINIDO));
        const procedure = (0, cloneDeep_1.default)(value.valor);
        const paramsList = procedure.getDeclarationParams();
        const insList = procedure.getInstrucciones();
        const procType = procedure.tipo;
        if (this.execParams.length !== paramsList.length)
            arbol.setSemanticError("Listado de parametros incorrectos");
        const procTable = new SymbolTable_1.default(tabla);
        paramsList.forEach((param, index) => {
            const newParamValue = this.execParams[index];
            const value = newParamValue.interpretar(arbol, tabla);
            param.setvalor(value);
            procTable.setValor(param.getidentificador(), param, true);
        });
        console.log(insList);
        for (let i of insList) {
            const valueToReturn = i.interpretar(arbol, procTable);
            if (i instanceof ReturnIns_1.default || valueToReturn instanceof ReturnIns_1.default) {
                if (i.tipoDato === procType) {
                    this.tipoDato = procType;
                    return valueToReturn;
                }
                else {
                    arbol.setSemanticError("Tipo de dato de retorno incorrecto");
                }
            }
        }
        //return get(value, 'valor')
        return null;
    }
}
exports.default = ProcedureExec;
