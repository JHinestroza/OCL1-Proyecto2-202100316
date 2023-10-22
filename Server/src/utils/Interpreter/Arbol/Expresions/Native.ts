import { Instruccion } from '../Abstract/Instruccion';
import Three from '../Symbol/Three';
import SymbolTable from '../Symbol/SymbolTable';
import Type, { DataType } from '../Symbol/Type';
import get from 'lodash/get';
import { Console, log } from 'console';

export default class Nativo extends Instruccion {
  valor: any;

  constructor(tipo: Type, valor: any, fila: number, columna: number) {
    super(tipo, fila, columna);
    this.valor = valor;
    //console.log('este valor estoy almacenando ' + this.valor)
  }

  interpretar(arbol: Three, tabla: SymbolTable) {

    if (this.tipoDato.getTipo() === DataType.ENTERO) {
      return this.valor;
    } else if (this.tipoDato.getTipo() === DataType.CADENA) {
      return this.valor.toString();
    } else if (this.tipoDato.getTipo() === DataType.DECIMAL) {
      return this.valor.toString();
    } else if (this.tipoDato.getTipo() === DataType.ID) {
      //console.log(this.tipoDato.getTipo)
      let value = tabla.getValor(this.valor)
      //console.log(value);
      this.tipoDato = get(value, 'tipo', new Type(DataType.INDEFINIDO));
      return get(value, 'valor')
    }
  }
}