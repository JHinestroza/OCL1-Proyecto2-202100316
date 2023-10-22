%{
    //codigo js
    // const controller = require('../../../controller/parser/parser');
    // const errores = require('./Exceptions/Error');
    // const nativo = require('./Expresions/Native');
     const aritmetico = require('./Arbol/Expresions/Aritmetica');
   	 const relacional = require('./Arbol/Expresions/Relacional');
     const logica = require('./Arbol/Expresions/Logica');
     const Tipo = require('./Arbol/Symbol/Type');
    // const impresion = require('./Instructions/Imprimir');   
    // const procedureExec = require('./Instructions/ProcedureExec');
     const ifIns = require('./Arbol/Instructions/IfIns');  
    // const procedureDec = require('./Instructions/ProcedureDec');
     const declaracion = require('./Arbol/Instructions/Declaracion');
    // const mientras = require('./Instructions/Mientras');
     const asignacion = require('./Arbol/Instructions/Asignacion');
    // const { Nodo } = require('./Symbol/Three');
	 const impresion = require('./Arbol/Instructions/Imprimir'); 
	 const nativo = require('./Arbol/Expresions/Native');
%}
%lex 


%options case-insensitive 
//inicio analisis lexico
%%
[\ \r\t\f\t]+            				{}
\n                       				{}
\-\-([^\r\n]*)?     	 				{}
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/] 	{}
[/][*][^*]*[*]+([^/*][^*]*[*]+)*[/]		{}

// reservadas
"IF"                {return 'IF';}
"THEN"              {return 'THEN';}
"BEGIN"             {return 'BEGIN';}
"END"               {return 'END';}
"PRINT"             {return 'PRINT';}
"DECLARE"			{return 'DECLARE'}
"AND"              	{return 'AND'}
"OR"               	{return 'OR'}
"NOT"              	{return 'NOT'} 
"LOOP"            	{return 'LOOP'}
"AVG"              	{return 'AVG'}
"DEFAULT"          	{return 'DEFAULT'}
"INT"              	{return 'INT'}
"DOUBLE"           	{return 'DOUBLE'}   
"FLOAT"            	{return 'FLOAT'} 
"DATE"             	{return 'RESDATE'} 
"VARCHAR"         	{return 'VARCHAR'} 
"BOOLEAN"          	{return 'BOOLEAN'}
"TRUE"             	{return 'TRUE'} 
"FALSE"            	{return 'FALSE'} 
"NULL"             	{return 'NULL'} 
"WHILE"           	{return 'WHILE'} 
"ELSE"             	{return 'ELSE'} 
"FOR"             	{return 'FOR'} 
"BREAK"           	{return 'BREAK'} 
"CONTINUE"        	{return 'CONTINUE'}
'SET'               {return 'SET'}   
"WHEN"              {return 'WHEN'} 
'CASE'              {return 'CASE'} 
'AS'                {return 'AS'}
'SELECT'           	{return 'SELECT'} 
'FROM'             	{return 'FROM'} 
'UPDATE'           	{return 'UPDATE'} 
'TRUNCATE'        	 {return 'TRUNCATE'} 
'CAST'             	{return 'CAST'} 
'FUNCTION'        	 {return 'FUNCTION'} 
'RETURNS'         	 {return 'RETURNS'} 
'RETURN'          	 {return 'RETURN'} 
'PROCEDURE'       	 {return 'PROCEDURE'} 
'LOWER'           	 {return 'LOWER'} 
'UPPER'           	 {return 'UPPER'} 
'ROUND'           	 {return 'ROUND'} 
'LEN'             	 {return 'LEN'} 
'TYPEOF'         	 {return 'TYPEOF'} 
'ADD'             	 {return 'ADD'} 
'LOOP'             	 {return 'LOOP'}
'AVG'              	 {return 'AVG'}
'IN'               	 {return 'IN'} 


 



//EXPRESIONES
[\"][^\"\n]+[\"]                    {yytext = yytext.substr(1,yyleng - 2);return 'APOSTROFE'; }
[\'][^\"\n]+[\']				 	{ yytext = yytext.substr(1,yyleng - 2); return 'CADENA_COMILLA';}
[0-9]+("."[0-9]+)?\b    			return 'DECIMAL';
[0-9]+\b                			return 'ENTERO';
[@][a-zA-Z_][a-zA-Z0-9_]*			return 'ID'
[a-zA-Z_][a-zA-Z0-9_]*			return 'ID2'


"Evaluar"           return 'REVALUAR';
";"                 return 'PTCOMA';
"("                 return 'PARIZQ';
")"                 return 'PARDER';
"["                 return 'CORIZQ';
"]"                 return 'CORDER';
","                 return 'COMMA';

"+"                 return 'MAS';
"-"                 return 'MENOS';
"*"                 return 'POR';
"/"                 return 'DIVIDIDO';
"="                 return 'IGUAL';
"!="               {return 'DIFERENTE'} 
"<="               {return 'MENORIGUAL'} 
">="               {return 'MAYORIGUAL'} 
">"                {return 'MAYOR'} 
"<"                {return 'MENOR'} 
"!"                {return 'NEGACION'} 
'..'                {return 'PUNTOS'} 



<<EOF>>                     return 'EOF';
.                           return 'INVALID'

/lex

%left 'MAS' 'MENOS' 'POR' 'DIVIDIDO'
%left 'MAYOR' 'MENOR' 'MAYORIGUAL' 'MENORIGUAL' 'IGUAL'
%left 'OR' 'AND'


%start INIT
//Inicio
//Definicion de gramatica
%%

INIT: INSTRUCCIONES EOF     {
        return {
            returnInstruction: $1.returnInstruction, 
           // nodeInstruction: (new Nodo("INIT")).generateProduction([$1//.nodeInstruction, 'EOF'])            
        };
    }
;

INSTRUCCIONES : 
    INSTRUCCIONES INSTRUCCION   {        
        $$={
            returnInstruction: [...$1.returnInstruction, $2.returnInstruction], 
           // nodeInstruction: (new Nodo("Instrucciones")).generateProduction([$1//.nodeInstruction,  $2//.nodeInstruction]) 
        };
    }
    | INSTRUCCION          {
        $$={
            returnInstruction: [$1.returnInstruction],
           // nodeInstruction: (new Nodo("Instrucciones")).generateProduction([$1//.nodeInstruction])
        };
    }
;

INSTRUCCION :
    	IMPRIMIR  PTCOMA              {
        $$={
            returnInstruction: $1.returnInstruction, 
           // nodeInstruction: (new Nodo("INSTRUCCION")).generateProduction([$1//.nodeInstruction]) 
        };
    } 
	| DECLARACION PTCOMA        {
        $$={
            returnInstruction: $1.returnInstruction, 
           // nodeInstruction: (new Nodo("INSTRUCCION")).generateProduction([$1//.nodeInstruction]) 
        };
    }
	|  IFINS                 {
        $$={
            returnInstruction: $1.returnInstruction, 
            //nodeInstruction: (new Nodo("INSTRUCCION")).generateProduction([$1.nodeInstruction]) 
        };
    }
;
/* IMPRIMIR */

IMPRIMIBLE:
    EXPRESION {
        $$ = {
            returnInstruction: $1.returnInstruction,
           // nodeInstruction: (new Nodo('IMPRIMIBLE')).generateProduction([$1//.nodeInstruction])
        }
    }  
;

IMPRIMIR : 
    PRINT IMPRIMIBLE  {
		//console.log('pase en imprimir  '+$2)
        $$= {
            returnInstruction: new impresion.default($2.returnInstruction,@1.first_line,@1.first_column),
           // nodeInstruction: (new Nodo('IMPRIMIR')).generateProduction([$1, $2, $3//.nodeInstruction, $4])
        }
    }
;
/*DECLARACION  */

 DECLARACION:
		DECLARE ID DATATYPES DEFAULT EXPRESION {
			//console.log("declare una varible "+$5)
        $$={
            returnInstruction: new declaracion.default($2, $3.returnInstruction, $5.returnInstruction, @1.first_line, @1.first_column), 
            //nodeInstruction: (new Nodo('Declaracion')).generateProduction([$1.nodeInstruction, 'identificador', 'igual', $4.nodeInstruction])
        }
    } 
;


/* SENTENCIA PARA EL IF */

IFINS:
    SIMPLEIF                {
        $$ = {
            returnInstruction: $1.returnInstruction,
            //nodeInstruction: (new Nodo('IFINS')).generateProduction([$1.nodeInstruction])
        }
    }                            
    // | RESIF PARABRE EXPRESION_LOGICA PARCIERRA LLAVIZQ INSTRUCCIONES LLAVDER ELSEIFSINS RESELSE LLAVIZQ INSTRUCCIONES LLAVDER 
    // {
    //     $$={
    //         returnInstruction: new ifIns.default($3,$6,$8,$11,@1.first_line,@1.first_column),
    //         nodeInstruction: (new Nodo('IFINS')).generateProduction([$1, $2, $3.nodeInstruction, $4, $5, $6.nodeInstruction, $7, $8.nodeInstruction, $9, $10, $11.nodeInstruction,$12])
    //     };
    // } 
;


SIMPLEIF:
    IF comparacion THEN INSTRUCCIONES END PTCOMA {
		console.log("he entrado aqui A UN IF" + $4);
        $$={
                returnInstruction: new ifIns.default($2,$4, undefined, undefined, @1.first_line, @1.first_column),
        //     //nodeInstruction: (new Nodo('SIMPLEIF')).generateProduction([$1, $2, $3.nodeInstruction, $4, $5, $6.nodeInstruction, $7])
        }
    }
;




/* EXPRESIONES */

EXPRESION
	: comparacion {
			$$ = {
				returnInstruction: $1.returnInstruction,
			// nodeInstruction: (new Nodo('IMPRIMIBLE')).generateProduction([$1//.nodeInstruction])
			}
		} 
    | logica {
			$$ = {
				returnInstruction: $1.returnInstruction,
			// nodeInstruction: (new Nodo('IMPRIMIBLE')).generateProduction([$1//.nodeInstruction])
			}
		} 
	| operaciones {
			$$ = {
				returnInstruction: $1.returnInstruction,
			// nodeInstruction: (new Nodo('IMPRIMIBLE')).generateProduction([$1//.nodeInstruction])
			}
		} 
    | ENTERO         			{
        $$={
            returnInstruction: new nativo.default(new Tipo.default(Tipo.DataType.ENTERO),$1, @1.first_line, @1.first_column),
            //nodeInstruction: (new Nodo('EXPRESION')).generateProduction(['CADENA'])
        }
    }
	| DECIMAL         			{
		//console.log('SOY UNA DECIMAL ' +$1)
        $$={
            returnInstruction: new nativo.default(new Tipo.default(Tipo.DataType.DECIMAL),$1, @1.first_line, @1.first_column),
            //nodeInstruction: (new Nodo('EXPRESION')).generateProduction(['CADENA'])
        }
    }
    
	| APOSTROFE					{
        $$={
            returnInstruction: new nativo.default(new Tipo.default(Tipo.DataType.CADENA),$1, @1.first_line, @1.first_column),
           // nodeInstruction: (new Nodo('EXPRESION')).generateProduction(['CADENA'])
        }
    }
	| CADENA_COMILLA					{
        $$={
            returnInstruction: new nativo.default(new Tipo.default(Tipo.DataType.CADENA),$1, @1.first_line, @1.first_column),
           // nodeInstruction: (new Nodo('EXPRESION')).generateProduction(['CADENA'])
        }
    }
	| PARIZQ IMPRIMIBLE PARDER 	{
        $$ = {
            returnInstruction: $2.returnInstruction,
           // nodeInstruction: (new Nodo('IMPRIMIBLE')).generateProduction([$1//.nodeInstruction])
        }
    } 
	| ID 	{
        $$ = {
            returnInstruction: new nativo.default(new Tipo.default(Tipo.DataType.ID),$1, @1.first_line, @1.first_column),
           // nodeInstruction: (new Nodo('IMPRIMIBLE')).generateProduction([$1//.nodeInstruction])
        }
    } 
	
	
;

comparacion
 : EXPRESION MAYOR EXPRESION {
        $$ = {
            returnInstruction: new relacional.default(relacional.tipoOp.MAYOR, $1.returnInstruction, $3.returnInstruction, @1.first_line, @1.first_column),
            //nodeInstruction: (new Nodo('EXPRESION_RELACIONAL')).generateProduction([$1.nodeInstruction, $2, $3.nodeInstruction])
        }
    }
 | EXPRESION MENOR EXPRESION {
        $$ = {
            returnInstruction: new relacional.default(relacional.tipoOp.MENOR, $1.returnInstruction, $3.returnInstruction, @1.first_line, @1.first_column),
            //nodeInstruction: (new Nodo('EXPRESION_RELACIONAL')).generateProduction([$1.nodeInstruction, $2, $3.nodeInstruction])
        }
    }
 | EXPRESION MAYORIGUAL EXPRESION {
        $$ = {
            returnInstruction: new relacional.default(relacional.tipoOp.MAYOR_IGUAL, $1.returnInstruction, $3.returnInstruction, @1.first_line, @1.first_column),
            //nodeInstruction: (new Nodo('EXPRESION_RELACIONAL')).generateProduction([$1.nodeInstruction, $2, $3.nodeInstruction])
        }
    }
 | EXPRESION MENORIGUAL EXPRESION{
        $$ = {
            returnInstruction: new relacional.default(relacional.tipoOp.MENOR_IGUAL, $1.returnInstruction, $3.returnInstruction, @1.first_line, @1.first_column),
            //nodeInstruction: (new Nodo('EXPRESION_RELACIONAL')).generateProduction([$1.nodeInstruction, $2, $3.nodeInstruction])
        }
    }
//  | EXPRESION DIFERENTE EXPRESION {
//         $$ = {
//             returnInstruction: new relacional.default(relacional.tipoOp.MAYOR, $1.returnInstruction, $3.returnInstruction, @1.first_line, @1.first_column),
//             //nodeInstruction: (new Nodo('EXPRESION_RELACIONAL')).generateProduction([$1.nodeInstruction, $2, $3.nodeInstruction])
//         }
//     }
;

DATATYPES:
    INT                                      {
		//console.log("ENTERO")
        $$={
            returnInstruction: new Tipo.default(Tipo.DataType.DECIMAL),
            //nodeInstruction: (new Nodo('DATATYPES')).generateProduction([$1])
        }
    }    
    | VARCHAR                                      {
		//console.log("ENTERO")
        $$={
            returnInstruction: new Tipo.default(Tipo.DataType.CADENA),
            //nodeInstruction: (new Nodo('DATATYPES')).generateProduction([$1])
        }
    }  
    | DOUBLE                                      {
		//console.log("ENTERO")
        $$={
            returnInstruction: new Tipo.default(Tipo.DataType.DECIMAL),
            //nodeInstruction: (new Nodo('DATATYPES')).generateProduction([$1])
        }
    }  
;

operaciones:
		EXPRESION MAS EXPRESION {
            //console.log("esta ese la suma: "+$1+" + "+$3)
        $$={
            returnInstruction: new aritmetico.default(aritmetico.tipoOp.SUMA, $1.returnInstruction, $3.returnInstruction, @1.first_line, @1.first_column),
            //nodeInstruction: (new Nodo('EXPRESION')).generateProduction([$1.nodeInstruction, 'SUMA', $3.nodeInstruction])
        }
    }
    | EXPRESION MENOS EXPRESION {
        $$={
            returnInstruction: new aritmetico.default(aritmetico.tipoOp.RESTA, $1.returnInstruction, $3.returnInstruction, @1.first_line, @1.first_column),
            //nodeInstruction: (new Nodo('EXPRESION')).generateProduction([$1.nodeInstruction, 'MENOS', $3.nodeInstruction])
        }
    }
    | EXPRESION POR EXPRESION {
        $$={
            returnInstruction: new aritmetico.default(aritmetico.tipoOp.MULTIPLICACION, $1.returnInstruction, $3.returnInstruction, @1.first_line, @1.first_column),
            //nodeInstruction: (new Nodo('EXPRESION')).generateProduction([$1.nodeInstruction, 'MENOS', $3.nodeInstruction])
        }
    }
    | EXPRESION DIVIDIDO EXPRESION {
        $$={
            returnInstruction: new aritmetico.default(aritmetico.tipoOp.DIVISION, $1.returnInstruction, $3.returnInstruction, @1.first_line, @1.first_column),
            //nodeInstruction: (new Nodo('EXPRESION')).generateProduction([$1.nodeInstruction, 'MENOS', $3.nodeInstruction])
        }
    }
;



logica:
    EXPRESION OR EXPRESION {
            $$ = {
                returnInstruction: new logica.default(logica.tipoOp.OR, $1.returnInstruction, $3.returnInstruction, @1.first_line, @1.first_column),
                //nodeInstruction: (new Nodo('EXPRESION_LOGICA')).generateProduction([$1.nodeInstruction, $2, $3.nodeInstruction])
            }
        }
    | EXPRESION AND EXPRESION {
            $$ = {
                returnInstruction: new logica.default(logica.tipoOp.AND, $1.returnInstruction, $3.returnInstruction, @1.first_line, @1.first_column),
                //nodeInstruction: (new Nodo('EXPRESION_LOGICA')).generateProduction([$1.nodeInstruction, $2, $3.nodeInstruction])
            }
        }
;
