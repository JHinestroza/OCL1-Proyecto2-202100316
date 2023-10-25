%{
    //codigo js
    const controller = require('../../controller/parser/parser');
    const errores = require('./Arbol/Exceptions/Error');
    const Ciclo = require('./Arbol/Instructions/CicloFor');
    const aritmetico = require('./Arbol/Expresions/Aritmetica');
   	const relacional = require('./Arbol/Expresions/Relacional');
    const logica = require('./Arbol/Expresions/Logica');
    const Tipo = require('./Arbol/Symbol/Type');  
    // const procedureExec = require('./Instructions/ProcedureExec');
    const ifIns = require('./Arbol/Instructions/IfIns');  
    // const procedureDec = require('./Instructions/ProcedureDec');
    const declaracion = require('./Arbol/Instructions/Declaracion');
    const mientras = require('./Arbol/Instructions/Mientras');
    const asignacion = require('./Arbol/Instructions/Asignacion');
    const transformado = require('./Arbol/Instructions/Transformar');
    const { Nodo } = require('./Arbol/Symbol/Three');
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
"DATE"             	{return 'DATE'} 
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
'CREATE'             {return 'CREATE'} 
'TABLE'              {return 'TABLE'}
'ALTER'              {return 'ALTER'}
'DROP'               {return 'DROP'}
'COLUMN'             {return 'COLUMN'}
'RENAME'             {return 'RENAME'}
'TO'                 {return 'TO'}

 



//EXPRESIONES
[\"][^\"\n]+[\"]                    {yytext = yytext.substr(1,yyleng - 2);return 'APOSTROFE'; }
[\'][^\"\n]+[\']				 	{ yytext = yytext.substr(1,yyleng - 2); return 'CADENA_COMILLA';}
[0-9]+("."[0-9]+)?\b    			return 'DECIMAL';
[0-9]+\b                			return 'ENTERO';
[@][a-zA-Z_][a-zA-Z0-9_]*			return 'ID'
[a-zA-Z_][a-zA-Z0-9_]*			    return 'ID2'


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
"%"                 return 'MOD';
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

%left 'MAS' 'POR' 'DIVIDIDO' 'MENOS' 'MOD'
%left 'MAYOR' 'MENOR' 'MAYORIGUAL' 'MENORIGUAL' 'IGUAL' 'DIFERENTE'
%left 'OR' 'AND' 'NEGACION'
%left UMENOS

%start INIT
//Inicio
//Definicion de gramatica
%%

INIT: INSTRUCCIONES EOF     {
        return {
            retorno: $1.retorno, 
             nodeInstruction: (new Nodo("INIT")).generateProduction([$1.nodeInstruction, 'EOF'])            
        };
    }
;

INSTRUCCIONES : 
    INSTRUCCIONES INSTRUCCION   {        
        $$={
            retorno: [...$1.retorno, $2.retorno], 
            nodeInstruction: (new Nodo("Instrucciones")).generateProduction([$1.nodeInstruction,  $2.nodeInstruction]) 
        };
    }
    | INSTRUCCION          {
        $$={
            retorno: [$1.retorno],
            nodeInstruction: (new Nodo("Instrucciones")).generateProduction([$1.nodeInstruction])
        };
    }
;

INSTRUCCION :
    	IMPRIMIR  PTCOMA    {
        $$={
            retorno: $1.retorno, 
            nodeInstruction: (new Nodo("INSTRUCCION")).generateProduction([$1.nodeInstruction]) 
        }
    } 
	| DECLARACION        {
        $$={
            retorno: $1.retorno, 
             nodeInstruction: (new Nodo("INSTRUCCION")).generateProduction([$1.nodeInstruction]) 
        };
    }
	|  SIMPLEIF                 {
        $$={
            retorno: $1.retorno, 
             nodeInstruction: (new Nodo("INSTRUCCION")).generateProduction([$1.nodeInstruction]) 
        };
    }
    |  IF_ELSE                 {
        $$={
            retorno: $1.retorno, 
             nodeInstruction: (new Nodo("INSTRUCCION")).generateProduction([$1.nodeInstruction]) 
        };
    }
    | WHILEINS {
        $$={
            retorno: $1.retorno, 
            nodeInstruction: (new Nodo("INSTRUCCION")).generateProduction([$1.nodeInstruction]) 
        };
    }
    | seteado {
        $$={
            retorno: $1.retorno, 
            nodeInstruction: (new Nodo("INSTRUCCION")).generateProduction([$1.nodeInstruction]) 
        };
    }
    | Ciclo_for {
        $$={
            retorno: $1.retorno, 
            nodeInstruction: (new Nodo("INSTRUCCION")).generateProduction([$1.nodeInstruction]) 
        };
    }
    | FNATIVOS {
        $$={
            retorno: $1.retorno, 
            nodeInstruction: (new Nodo("INSTRUCCION")).generateProduction([$1.nodeInstruction]) 
        };
    }
    | CREATE_TABLE      {}
    | INVALID               {controller.listaErrores.push(new errores.default('ERROR LEXICO',$1,@1.first_line,@1.first_column));}
    | error  PTCOMA         {controller.listaErrores.push(new errores.default(`ERROR SINTACTICO`,"Se esperaba token",@1.first_line,@1.first_column));}
;
/* IMPRIMIR */

IMPRIMIBLE:
    EXPRESION {
        $$ = {
            retorno: $1.retorno,
             nodeInstruction: (new Nodo('IMPRIMIBLE')).generateProduction([$1.nodeInstruction])
        }
    }  
;

IMPRIMIR : 
    PRINT IMPRIMIBLE  {
		//console.log('pase en imprimir  '+$2)
        $$= {
            retorno: new impresion.default($2.retorno,@1.first_line,@1.first_column),
             nodeInstruction: (new Nodo('IMPRIMIR')).generateProduction([$1, $2.nodeInstruction,])
        }
    }
;
/*DECLARACION  */

 DECLARACION:
        DECLARE ID DATATYPES DEFAULT EXPRESION PTCOMA{
            
        $$={
            retorno: new declaracion.default($2, $3.retorno, $5.retorno, @1.first_line, @1.first_column), 
             nodeInstruction: (new Nodo('Declaracion')).generateProduction([$1.nodeInstruction, 'identificador',  $3.nodeInstruction])
        }
    } 
        | DECLARE ID DATATYPES PTCOMA{
          $$={ 
            retorno: new declaracion.default($2, $3.retorno, new nativo.default(new Tipo.default(Tipo.DataType.INDEFINIDO),0, @1.first_line, @1.first_column), @1.first_line, @1.first_column), 
            nodeInstruction: (new Nodo('Declaracion')).generateProduction([$1.nodeInstruction, 'identificador',  $3.nodeInstruction])
        }
    } 
;


/* SENTENCIA PARA EL IF */

SIMPLEIF:
    IF EXPRESION THEN Encapsulamiento PTCOMA {
        $$={
            retorno: new ifIns.default($2.retorno,$4.retorno, undefined, undefined, @1.first_line, @1.first_column),
            nodeInstruction: (new Nodo('SIMPLEIF')).generateProduction([$1, $2, $4.nodeInstruction])
        }
    }

;

 IF_ELSE:
    IF EXPRESION THEN INSTRUCCIONES ELSE INSTRUCCIONES END IF PTCOMA{
        $$={
            retorno: new ifIns.default($2.retorno,$4.retorno, undefined, $6.retorno, @1.first_line, @1.first_column),
             nodeInstruction: (new Nodo('IFELSE')).generateProduction([$4.nodeInstruction , $5.nodeInstruction])
        }
    }
 ;

 IF_ANIDADO:
        IF EXPRESION THEN INSTRUCCIONES ELSEIFSINS ELSE  INSTRUCCIONES END IF PTCOMA 
    
 ;

 IFSIMPLE:
    IF EXPRESION THEN INSTRUCCION {
        $$={
            retorno: new ifIns.default($2.retorno,$4.retorno, undefined, undefined, @1.first_line, @1.first_column),
            nodeInstruction: (new Nodo('SIMPLEIF')).generateProduction([$2.nodeInstruction,$4.nodeInstruction])
        }
    }
 ;


ELSEIFSINS :
    ELSEIFSINS ELSE IFSIMPLE 
            {
                $1.retorno.push($3.retorno); 
                $$={
                    retorno: $1.retorno,
                    nodeInstruction: (new Nodo('ELSEIFSINS')).generateProduction([$1.nodeInstruction, $2, $3.nodeInstruction])
                }
            }
  | RESELSE IFSIMPLE  
            {
                $$={
                    retorno: [$2],
                    nodeInstruction: (new Nodo('ELSEIFSINS')).generateProduction([$1, $2.nodeInstruction])
                }
            }
;


/*WHILE*/
WHILEINS:
    WHILE EXPRESION Encapsulamiento PTCOMA {
        $$ = {
            retorno: new mientras.default($2.retorno,$3.retorno,@1.first_line,@1.first_column),
            nodeInstruction: (new Nodo("WHILE")).generateProduction([$1, $2.nodeInstruction, $3.nodeInstruction])
        }
    }
;

/*CICLO FOR */

Ciclo_for:
    FOR EXPRESION IN EXPRESION PUNTOS EXPRESION  Encapsulamiento LOOP PTCOMA
    {
        console.log("ciclo for")
        $$ = {
            retorno: new Ciclo.default($4.retorno,$6.retorno,$7.retorno,@1.first_line,@1.first_column),
            nodeInstruction: (new Nodo("FOR")).generateProduction([$1, $2.nodeInstruction, $4.nodeInstruction , $6.nodeInstruction, $7.nodeInstruction])
        }
    }
;



/*SETEADOS*/
seteado: SET ID IGUAL EXPRESION PTCOMA {
        $$ = {
            retorno: new asignacion.default($2, $4.retorno,@1.first_line,@1.first_column),
            nodeInstruction: (new Nodo("ASIGNACION")).generateProduction([$1, $2, $3.nodeInstruction])
        }
    }
;


/*FUNCIONES NATIVAS*/

ENTRADA:
     APOSTROFE					{
        $$={
            retorno: new nativo.default(new Tipo.default(Tipo.DataType.CADENA),$1, @1.first_line, @1.first_column),
            nodeInstruction: (new Nodo('ENTRADA')).generateProduction(['CADENA'])
        }
    }
	| CADENA_COMILLA					{
        $$={
            retorno: new nativo.default(new Tipo.default(Tipo.DataType.CADENA),$1, @1.first_line, @1.first_column),
            nodeInstruction: (new Nodo('ENTRADA')).generateProduction(['CADENA'])
        }
    }
;

FNATIVOS:
    SELECT LOWER PARIZQ ENTRADA PARDER PTCOMA{
        $$ = {
            retorno: new transformado.default(  $4.retorno  , transformado.cambio.LOWER,null,@1.first_line,@1.first_column),
            nodeInstruction: (new Nodo("FNATIVOS")).generateProduction([$1, $2, $4.nodeInstruction])
        }
    }
    | SELECT UPPER PARIZQ ENTRADA PARDER PTCOMA{
        $$ = {
            retorno: new transformado.default(  $4.retorno  , transformado.cambio.UPPER,null,@1.first_line,@1.first_column),
             nodeInstruction: (new Nodo("ASIGNACION")).generateProduction([$1, $2, $4.nodeInstruction])
        }
    }
    | SELECT LEN PARIZQ ENTRADA PARDER PTCOMA{
        $$ = {
            retorno: new transformado.default(  $4.retorno  , transformado.cambio.LEN, null ,@1.first_line,@1.first_column),
             nodeInstruction: (new Nodo("FNATIVOS")).generateProduction([$1, $2, $4.nodeInstruction])
        }
    }
    | SELECT ROUND PARIZQ DECIMAL COMMA DECIMAL PARDER PTCOMA{
        $$ = {
            retorno: new transformado.default( new nativo.default(new Tipo.default(Tipo.DataType.DECIMAL),$4 ,@1.first_line, @1.first_column) , transformado.cambio.ROUND, $6,@1.first_line,@1.first_column),
            nodeInstruction: (new Nodo("FNATIVOS")).generateProduction([$1, $2, $4,$5,$6])
        }
    }
    | SELECT TYPEOF PARIZQ EXPRESION  PARDER PTCOMA{
        $$ = {
            retorno: new transformado.default( $4.retorno , transformado.cambio.TypeOf, null ,@1.first_line,@1.first_column),
             nodeInstruction: (new Nodo("FNATIVOS")).generateProduction([$1, $2, $4.nodeInstruction])
        }
    }
    | SELECT TRUNCATE PARIZQ DECIMAL COMMA DECIMAL PARDER PTCOMA{
        $$ = {
            retorno: new transformado.default( new nativo.default(new Tipo.default(Tipo.DataType.DECIMAL),$4 ,@1.first_line, @1.first_column) , transformado.cambio.TRUNCATE, $6,@1.first_line,@1.first_column),
            nodeInstruction: (new Nodo("FNATIVOS")).generateProduction([$1, $2, $4,$5,$6])
        }
    }
    

;



/* EXPRESIONES */

EXPRESION
	: COMPARATIVAS {
			$$ = {
				retorno: $1.retorno,
			    nodeInstruction: (new Nodo('EXPRESION')).generateProduction([$1.retorno])
			}
		} 
	| operaciones {
			$$ = {
				retorno: $1.retorno,
			     nodeInstruction: (new Nodo('EXPRESION')).generateProduction([$1.retorno])
			}
		} 
    | ENTERO         			{
        $$={
            retorno: new nativo.default(new Tipo.default(Tipo.DataType.DECIMAL),$1, @1.first_line, @1.first_column),
             nodeInstruction: (new Nodo('EXPRESION')).generateProduction(['ENTERO'])
        }
    }
	| DECIMAL         			{
		//console.log('SOY UNA DECIMAL ' +$1)
        $$={
            retorno: new nativo.default(new Tipo.default(Tipo.DataType.DECIMAL),$1, @1.first_line, @1.first_column),
            nodeInstruction: (new Nodo('EXPRESION')).generateProduction(['DECIMAL'])
        }
    }
    
	| APOSTROFE					{
        $$={
            retorno: new nativo.default(new Tipo.default(Tipo.DataType.CADENA),$1, @1.first_line, @1.first_column),
             nodeInstruction: (new Nodo('EXPRESION')).generateProduction(['APOSTROFE'])
        }
    }
	| CADENA_COMILLA					{
        $$={
            retorno: new nativo.default(new Tipo.default(Tipo.DataType.CADENA),$1, @1.first_line, @1.first_column),
             nodeInstruction: (new Nodo('EXPRESION')).generateProduction(['CADENA_COMILLA'])
        }
    }
	| PARIZQ EXPRESION PARDER 	{
        $$ = {
            retorno: $2.retorno,
            nodeInstruction: (new Nodo('EXPRESION')).generateProduction([$1, $2.nodeInstruction, $3])
        }
    } 
	| ID 	{
        $$ = {
            retorno: new nativo.default(new Tipo.default(Tipo.DataType.ID),$1, @1.first_line, @1.first_column),
            nodeInstruction: (new Nodo('EXPRESION')).generateProduction([$1])
        }
    } 
    | ID2 	{
        $$ = {
            retorno: new nativo.default(new Tipo.default(Tipo.DataType.ID),$1, $1.first_line, $1.first_column),
            nodeInstruction: (new Nodo('EXPRESION')).generateProduction([$1])
        }
    } 
    | CASTEO {
        $$ = {
            retorno: $1.retorno, 
             nodeInstruction: (new Nodo('EXPRESION')).generateProduction([$1.retorno])           
        };
    }
	
		
;


DATATYPES:
    INT                                      {
		//console.log("ENTERO")
        $$={
            retorno: new Tipo.default(Tipo.DataType.DECIMAL),
            nodeInstruction: (new Nodo('DATATYPES')).generateProduction([$1])
        }
    }    
    | VARCHAR                                      {
		//console.log("ENTERO")
        $$={
            retorno: new Tipo.default(Tipo.DataType.CADENA),
            nodeInstruction: (new Nodo('DATATYPES')).generateProduction([$1])
        }
    }  
    | DOUBLE                                      {
		//console.log("ENTERO")
        $$={
            retorno: new Tipo.default(Tipo.DataType.DECIMAL),
            nodeInstruction: (new Nodo('DATATYPES')).generateProduction([$1])
        }
    }  
    | DATE                                      {
		//console.log("ENTERO")
        $$={
            retorno: new Tipo.default(Tipo.DataType.DATE),
            nodeInstruction: (new Nodo('DATATYPES')).generateProduction([$1])
        }
    }  
;

/* CREATE TABLE*/
CREATE_TABLE:
    CREATE TABLE PTCOMA {}
;

/* UPDATE TABLE*/



Variables:
        Variables variable

        | variable

;

variable: ID2 DATATYPES;


operaciones:
    MENOS EXPRESION %prec UMENOS {
        $$={
            retorno: new aritmetico.default(aritmetico.tipoOp.RESTA,  new nativo.default(new Tipo.default(Tipo.DataType.DECIMAL),0, @1.first_line, @1.first_column)  , $2.retorno, @1.first_line, @1.first_column),
            nodeInstruction: (new Nodo('OPERACIONES')).generateProduction([ 'MENOS', $1.nodeInstruction])
        }
    }
	| EXPRESION MAS EXPRESION {
            //console.log("esta ese la suma: "+$1+" + "+$3)
        $$={
            retorno: new aritmetico.default(aritmetico.tipoOp.SUMA, $1.retorno, $3.retorno, @1.first_line, @1.first_column),
             nodeInstruction: (new Nodo('OPERACIONES')).generateProduction([$1.nodeInstruction, 'SUMA', $3.nodeInstruction])
        }
    }
    | EXPRESION MENOS EXPRESION {
        $$={
            retorno: new aritmetico.default(aritmetico.tipoOp.RESTA, $1.retorno, $3.retorno, @1.first_line, @1.first_column),
            nodeInstruction: (new Nodo('OPERACIONES')).generateProduction([$1.nodeInstruction, 'MENOS', $3.nodeInstruction])
        }
    }
    | EXPRESION POR EXPRESION {
        $$={
            retorno: new aritmetico.default(aritmetico.tipoOp.MULTIPLICACION, $1.retorno, $3.retorno, @1.first_line, @1.first_column),
             nodeInstruction: (new Nodo('OPERACIONES')).generateProduction([$1.nodeInstruction, 'MULTIPLICACION', $3.nodeInstruction])
        }
    }
    | EXPRESION DIVIDIDO EXPRESION {
        $$={
            retorno: new aritmetico.default(aritmetico.tipoOp.DIVISION, $1.retorno, $3.retorno, @1.first_line, @1.first_column),
            nodeInstruction: (new Nodo('OPERACIONES')).generateProduction([$1.nodeInstruction, 'DIVIDO', $3.nodeInstruction])
        }
    }
    | EXPRESION MOD EXPRESION {
        $$={
            retorno: new aritmetico.default(aritmetico.tipoOp.MOD, $1.retorno, $3.retorno, @1.first_line, @1.first_column),
            nodeInstruction: (new Nodo('OPERACIONES')).generateProduction([$1.nodeInstruction, 'MOD', $3.nodeInstruction])
        }
    }
    
;
Encapsulamiento:
    BEGIN INSTRUCCIONES END {
			$$ = {
				retorno: $2.retorno,
			     nodeInstruction: (new Nodo('ENCAPSULADO')).generateProduction([$1,$2.retorno, $3])
			}
		}
;


relacion
    : EXPRESION MAYOR EXPRESION {
        console.log("RELACION  "+$1+" >"+$3)
            $$ = {
                retorno: new relacional.default(relacional.tipoOp.MAYOR, $1.retorno, $3.retorno, @1.first_line, @1.first_column),
                nodeInstruction: (new Nodo('EXPRESION_RELACIONAL')).generateProduction([$1.nodeInstruction, $2, $3.nodeInstruction])
            }
        }
    | EXPRESION MENOR EXPRESION {
            $$ = {
                retorno: new relacional.default(relacional.tipoOp.MENOR, $1.retorno, $3.retorno, @1.first_line, @1.first_column),
                nodeInstruction: (new Nodo('EXPRESION_RELACIONAL')).generateProduction([$1.nodeInstruction, $2, $3.nodeInstruction])
            }
        }
    | EXPRESION MAYORIGUAL EXPRESION {
            $$ = {
                retorno: new relacional.default(relacional.tipoOp.MAYOR_IGUAL, $1.retorno, $3.retorno, @1.first_line, @1.first_column),
                nodeInstruction: (new Nodo('EXPRESION_RELACIONAL')).generateProduction([$1.nodeInstruction, $2, $3.nodeInstruction])
            }
        }
    | EXPRESION MENORIGUAL EXPRESION{
            $$ = {
                retorno: new relacional.default(relacional.tipoOp.MENOR_IGUAL, $1.retorno, $3.retorno, @1.first_line, @1.first_column),
                nodeInstruction: (new Nodo('EXPRESION_RELACIONAL')).generateProduction([$1.nodeInstruction, $2, $3.nodeInstruction])
            }
        }
    | EXPRESION IGUAL EXPRESION{
        $$ = {
            retorno: new relacional.default(relacional.tipoOp.IGUAL, $1.retorno, $3.retorno, @1.first_line, @1.first_column),
            nodeInstruction: (new Nodo('EXPRESION_RELACIONAL')).generateProduction([$1.nodeInstruction, $2, $3.nodeInstruction])
        }
    }
    | EXPRESION DIFERENTE EXPRESION{
        $$ = {
            retorno: new relacional.default(relacional.tipoOp.IGUAL, $1.retorno, $3.retorno, @1.first_line, @1.first_column),
            nodeInstruction: (new Nodo('EXPRESION_RELACIONAL')).generateProduction([$1.nodeInstruction, $2, $3.nodeInstruction])
        }
    }
    
; 

logica: 
    EXPRESION OR EXPRESION {
            $$ = {
                retorno: new logica.default(logica.tipoOp.OR, $1.retorno, $3.retorno, @1.first_line, @1.first_column),
                nodeInstruction: (new Nodo('EXPRESION_LOGICA')).generateProduction([$1.nodeInstruction, $2, $3.nodeInstruction])
            }
        }
    | EXPRESION AND EXPRESION {
            $$ = {
                retorno: new logica.default(logica.tipoOp.AND, $1.retorno, $3.retorno, @1.first_line, @1.first_column),
                nodeInstruction: (new Nodo('EXPRESION_LOGICA')).generateProduction([$1.nodeInstruction, $2, $3.nodeInstruction])
            }
        }
    | EXPRESION NEGACION EXPRESION {
            $$ = {
                retorno: new logica.default(logica.tipoOp.NOT, $1.retorno, $3.retorno, @1.first_line, @1.first_column),
                nodeInstruction: (new Nodo('EXPRESION_LOGICA')).generateProduction([$1.nodeInstruction, $2, $3.nodeInstruction])
            }
        }

 ; 

COMPARATIVAS:
    relacion{
			$$ = {
				retorno: $1.retorno,
			    nodeInstruction: (new Nodo("COMPARATIVAS")).generateProduction([$1.nodeInstruction]) 
			}
		}
    | logica{
			$$ = {
				retorno: $1.retorno,
			    nodeInstruction: (new Nodo("COMPARATIVAS")).generateProduction([$1.nodeInstruction]) 
			}
		}

;

CASTEO:
    CAST PARIZQ ID AS DATATYPES PARDER  {
        console.log("llegue a casteo")
        $$={
             retorno: new nativo.default(new Tipo.default(Tipo.DataType.ID),$3, @1.first_line, @1.first_column),
             nodeInstruction: (new Nodo('CASTEO')).generateProduction([$3.nodeInstruction,  $5.nodeInstruction])
        }
    } 


;