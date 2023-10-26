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
    const tokem = require('../../controller/parser/parser');
    let {consola} = require('./Arbol/Exceptions/Reportes')
    let {printErrors} = require('./Arbol/Exceptions/Reportes')
    let {TypeError} = require('./Arbol/Exceptions/Errores')
    const reporte_error = require('./Arbol/Exceptions/Errores');

    let {printTokems} = require('./Arbol/Tokems/ReporteTokems')
    let {TypeTokem} = require('./Arbol/Tokems/Tokems')
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
"IF"                {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));    return 'IF'; }
"THEN"              { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));      return 'THEN'; }
"BEGIN"             {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));      return 'BEGIN'; }
"END"               {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'END'; }
"PRINT"             {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'PRINT'; }
"DECLARE"           { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));      return 'DECLARE'; }
"AND"               {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'AND'; }
"OR"                {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'OR'; }
"NOT"               {   printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));    return 'NOT'; }
"LOOP"              {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'LOOP'; }
"AVG"               {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'AVG'; }
"DEFAULT"           {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'DEFAULT'; }
"INT"               { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));      return 'INT'; }
"DOUBLE"            {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'DOUBLE'; }
"FLOAT"             {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'FLOAT'; }
"DATE"              { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));      return 'DATE'; }
"VARCHAR"           { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));      return 'VARCHAR'; }
"BOOLEAN"           {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'BOOLEAN'; }
"TRUE"              { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));      return 'TRUE'; }
"FALSE"             {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'FALSE'; }
"NULL"              { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));      return 'NULL'; }
"WHILE"             {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'WHILE'; }
"ELSE"              {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'ELSE'; }
"FOR"               {   printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));    return 'FOR'; }
"BREAK"             {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'BREAK'; }
"CONTINUE"          {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'CONTINUE'; }
"SET"               { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));      return 'SET'; }
"WHEN"              {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'WHEN'; }
"CASE"              {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'CASE'; }
"AS"                { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));      return 'AS'; }
"SELECT"            {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'SELECT'; }
"FROM"              {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'FROM'; }
"UPDATE"            { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));      return 'UPDATE'; }
"TRUNCATE"          { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));      return 'TRUNCATE'; }
"CAST"              { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));      return 'CAST'; }
"FUNCTION"          {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'FUNCTION'; }
"RETURNS"           { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));      return 'RETURNS'; }
"RETURN"            {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'RETURN'; }
"PROCEDURE"         { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));      return 'PROCEDURE'; }
"LOWER"             {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'LOWER'; }
"UPPER"             { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));      return 'UPPER'; }
"ROUND"             {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'ROUND'; }
"LEN"               { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));      return 'LEN'; }
"TYPEOF"            { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));      return 'TYPEOF'; }
"ADD"               { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));      return 'ADD'; }
"LOOP"              { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));      return 'LOOP'; }
"AVG"               { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));      return 'AVG'; }
"IN"                { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));      return 'IN'; }
"CREATE"            { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));      return 'CREATE'; }
"TABLE"             {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'TABLE'; }
'ALTER'             {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'ALTER'}
'DROP'              {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'DROP'}
'COLUMN'            {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'COLUMN'}
'RENAME'            {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'RENAME'}
'TO'                {  printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `));     return 'TO'}

 



//EXPRESIONES
[\"][^\"\n]+[\"]                    { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{APOSTROFE}" `));   return 'APOSTROFE'; }
[\'][^\"\n]+[\']				 	{ printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{CADENA_COMILLA}" `));  return 'CADENA_COMILLA';}
[0-9]+("."[0-9]+)?\b    			{ printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{DECIMAL}" `));    return 'DECIMAL';}
[0-9]+\b                			{ printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{ENTERO}" `));  return 'ENTERO';}
[@][a-zA-Z_][a-zA-Z0-9_]*			{printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{ID}" `));  return 'ID'}
[a-zA-Z_][a-zA-Z0-9_]*			    {printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{ID2}" `));    return 'ID2'}


"Evaluar"           {printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{yytext}" `)); return 'REVALUAR';}
";"                 {printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{PTCOMA}" `));  return 'PTCOMA';}
"("                { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{PARIZQ}" `));  return 'PARIZQ';}
")"                 { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{PARDER}" `)); return 'PARDER';}
"["                 { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{CORIZQ}" `));  return 'CORIZQ';}
"]"                 { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{CORDER}" `));  return 'CORDER';}
","                 { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{COMMA}" `));   return 'COMMA';}

"+"                 {printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{MAS}" `));    return 'MAS';}
"-"                 { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{MENOS}" `)); return 'MENOS';}
"*"                 {printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{POR}" `)); return 'POR';}
"/"                 {printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{DIVIDIDO}" `));   return 'DIVIDIDO';}
"%"                {printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{MOD}" `));  return 'MOD';}
"="                 {printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{IGUAL}" `));  return 'IGUAL';}
"!="               { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{DIFERENTE}" `)); return 'DIFERENTE'} 
"<="               { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{MENORIGUAL}" `));  return 'MENORIGUAL'} 
">="               { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{MAYORIGUAL}" `));  return 'MAYORIGUAL'} 
">"                {printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{MAYOR}" `));   return 'MAYOR'} 
"<"                {printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{MENOR}" `));    return 'MENOR'} 
"!"                { printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{NEGACION}" `));    return 'NEGACION'} 
'..'               {printTokems.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeTokem.TOKEMS, `El caracter "{PUNTOS}" `));     return 'PUNTOS'} 



<<EOF>>                     return 'EOF';
.                           { console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column);
                            consola.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeError.LEXICO,`El caracter "${yytext}" `));
                            controller.listaErrores.push(new errores.default('ERROR LEXICO',yytext,yylloc.first_line, yylloc.first_column));
                            printErrors.push(new reporte_error.Errores(yylloc.first_line,yylloc.first_column,TypeError.LEXICO,`El caracter "${yytext}" `));
                            } 

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
    | CREATE_TABLE{
        $$={
            retorno: $1.retorno, 
            nodeInstruction: (new Nodo("INSTRUCCION")).generateProduction([$1.nodeInstruction]) 
        };
    }
    | error PTCOMA         {controller.listaErrores.push(new errores.default(`ERROR SINTACTICO`,"Se esperaba token",@1.first_line,@1.first_column));
                             consola.push(new reporte_error.Errores(@1.first_line, @1.first_column  ,TypeError.SIN,`El caracter "${yytext}" `));
                            printErrors.push(new reporte_error.Errores(@1.first_line , @1.first_column ,TypeError.SIN,`El caracter "${yytext}" `))
                            }
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
        DECLARE Variables PTCOMA{
          $$={ 
            retorno: $2.retorno, 
            nodeInstruction: (new Nodo('Variables')).generateProduction([$1,$2.nodeInstruction])
        }
}
;

Variables:
        Variables COMMA variable{ 
          $$={ 
            retorno: $1.retorno, 
            nodeInstruction: (new Nodo('Variables')).generateProduction([$1.nodeInstruction])
        }
}
        | variable{
          $$={ 
            retorno: $1.retorno, 
            nodeInstruction: (new Nodo('Variables')).generateProduction([$1.nodeInstruction])
        }
}
;

variable: ID DATATYPES{
          $$={ 
            retorno: new declaracion.default($1, $2.retorno, new nativo.default(new Tipo.default(Tipo.DataType.INDEFINIDO),0, @1.first_line, @1.first_column), @1.first_line, @1.first_column), 
            nodeInstruction: (new Nodo('variable')).generateProduction([$1.nodeInstruction,  $2.nodeInstruction])
        }
}
        | ID DATATYPES DEFAULT EXPRESION{
            
        $$={
            retorno: new declaracion.default($1, $2.retorno, $4.retorno, @1.first_line, @1.first_column), 
             nodeInstruction: (new Nodo('variable')).generateProduction([$1 , $2.nodeInstruction, $3,  $4.nodeInstruction])
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
    CREATE TABLE APOSTROFE PTCOMA {
		//console.log('pase en imprimir  '+$2)
        $$= {
            retorno: new impresion.default( new nativo.default(new Tipo.default(Tipo.DataType.CADENA),$3, @1.first_line, @1.first_column),@1.first_line,@1.first_column),
            //nodeInstruction: (new Nodo('IMPRIMIR')).generateProduction([$1, $2.nodeInstruction,])
        }
    }
;

/* UPDATE TABLE*/


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