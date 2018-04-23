package lexico;

import java.util.Stack;
%%
%class Flexer
%public
%standalone
%line
%column
%unicode

%{
  public String tokens;
  public int spaceCount;
  public Stack<Integer> pila;

  private void emptyStack(){
    int level = 0;
    while(!pila.isEmpty()){
      level = pila.pop();
      if(level!=0) tokens +="DEINDENTA("+level+")\n";
    }
    pila.push(0);
  }

  private boolean ident(){
    String dedents = "";
    if(pila.empty()){ //ponerle un cero a la pila si esta vacia
      pila.push(new Integer(0));
    }

    Integer tope = pila.peek();
    if(tope != spaceCount){
      //Se debe emitir un DEDENT por cada nivel mayor al actual
            if(tope > spaceCount){
                while(pila.peek() > spaceCount &&  pila.peek()!=0 ){
                    dedents += "DEINDENTA("+pila.pop()+")\n";
                }
                if(pila.peek() == spaceCount){
                    tokens += dedents;
                    return true;
                }
                tokens +="Error de indentación, linea "+ (yyline+1)+ ".\n";
                return false;
            }
        //El nivel actual de indentación es mayor a los anteriores.
            pila.push(spaceCount);
            tokens += "INDENTA("+spaceCount+") ";
            return true;
        }
        //El nivel actual es igual al anterior.
        return true;
  }
%}

%init{
  tokens = "";
  pila = new Stack<Integer>();
  pila.push(0);
  spaceCount = 0;
%init}

SALTO           = (\r|\n|\r\n)+
CHAR_LITERAL   	= ([:letter:] | [:digit:] | "_" | "$" | " " | "#" | {OPERADOR} | {SEPARADOR}) | "\\" | "\\\""
SEPARADOR  		  = ("(" | ")" | ":" | ";" )
OPERADOR        = "+" | "*" | "**" | "-" | "/" | "//" | "%" | "=" | "!"
COMPARADOR      = "<" | ">" | ">=" | "<=" | "==" | "!="
BOOLEANO        = "True" | "False"
ASCIIDIGIT      = [0-9]
DIGIT           = {ASCIIDIGIT}
OCTIT           = [0-7]
HEXIT           = {DIGIT} | [A-Fa-f]
DECIMAL         = {DIGIT}+
OCTAL           = {OCTIT}+
HEXADECIMAL     = {HEXIT}+
ENTERO          = {DECIMAL} | "0o" {OCTAL} | "0O" {OCTAL} | "0x" {HEXADECIMAL} | "0X" {HEXADECIMAL}
FLOTANTE        = {DECIMAL} "." {DECIMAL} {EXPONENTE}? | {DECIMAL} {EXPONENTE}?
EXPONENTE       = ("e" | "E") ("+" | "-")? {DECIMAL}
PRINT           = "print"
IF              = "if"
ELSE            = "else"
ELIF            = "elif"
WHILE           = "while"
NOT             = "not"
AND             = "and"
OR             = "or"
IDENTIFICADOR   = [a-zA-Z_]([a-zA-Z0-9_])*
COMENTARIO 		=     	"#".*{SALTO}

%state INDENT, INITIAL, CADENA

%%
{COMENTARIO}      			{}

<<EOF>>  { emptyStack(); return 0;}

<CADENA>{
  {CHAR_LITERAL}*(\" | ' )			{ tokens += "STRING(" + yytext().substring(0,yylength()-1) +  ") ";
  					 yybegin(INITIAL);}
  {SALTO}				{ tokens += "Cadena mal construida, linea " + (yyline+1); return 0;}
}

<YYINITIAL>{
  " "+                        		{ tokens += "Error de indentación al inicio del archivo.\n"; return 0;}
  .                               	{ yypushback(1); yybegin(INITIAL);}
}

<INITIAL> {
  \"					{ yybegin(CADENA); }
  '				{ yybegin(CADENA); }
  [ \t\f]         {  }
  {SALTO}     { tokens += "SALTO\n"; spaceCount=0; yybegin(INDENT); }
  {OPERADOR}      { tokens += "OPERADOR("+yytext() + ") "; }
  {COMPARADOR}      { tokens += "COMPARADOR("+yytext() + ") "; }
  {SEPARADOR}      { tokens += "SEPARADOR "; }
  {BOOLEANO}      { tokens += "BOOLEANO("+yytext() + ") "; }
  {ENTERO}      { tokens += "ENTERO("+yytext() + ") "; }
  {FLOTANTE}      { tokens += "FLOTANTE("+yytext() + ") "; }
  {PRINT}      { tokens += "PRINT ";  }
  {IF}      { tokens += "IF ";  }
  {ELSE}      { tokens += "ELSE "; }
  {ELIF}      { tokens += "ELIF "; }
  {WHILE}      { tokens += "WHILE ";  }
  {NOT}      { tokens += "NOT ";  }
  {AND}      { tokens += "AND ";  }
  {OR}      { tokens += "OR ";  }
  {IDENTIFICADOR}      { tokens += "IDENTIFICADOR("+yytext() + ") "; }
}

<INDENT> {
  {SALTO}     { spaceCount=0; }
  [ ]         { spaceCount++; }
  [\t\f]         { spaceCount+=4; }
  .         { yypushback(1);
              if(!ident()) return 0;
              yybegin(INITIAL);}
}
.             { tokens += "Caracter ilegal <"+yytext()+">. En la linea "+ (yyline+1)+ ".\n"; return 0; }
