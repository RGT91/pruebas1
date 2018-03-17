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
  public Stack<Integer> stack;

  private void emptyStack(){
    int level = 0;
    while(!stack.isEmpty()){
      level = stack.pop();
      if(level!=0) tokens +="DEINDENTA("+level+")\n";
    }
    stack.push(0);
  }

  private boolean ident(){
    int level = 0;
    if(spaceCount==0){
      emptyStack();
      return true;
    }else{
      if(!stack.isEmpty()){
        level = stack.peek();
        if(spaceCount > level){
          tokens +="INDENTA("+spaceCount+") ";
          stack.push(spaceCount);
          return true;
        }else{
          while(!stack.isEmpty()){
            level = stack.pop();
            if(level < spaceCount){
              tokens +="Error de indentación, linea "+ (yyline+1)+ ".\n";
              return false;
            }else if(level==0){
              stack.push(0);
              return false;
            }else if(level == spaceCount) {
              stack.push(level);
              return true;
            }else if(level > spaceCount){
              tokens +="DEINDENTA("+level+")\n";
            }
          }
          tokens +="Error de indentación, linea "+ (yyline+1)+ ".\n";
          return false;
        }
      }else{
        tokens +="Error de indentación, linea "+ (yyline+1)+ ".\n";
        return false;
      }
    }
  }
%}

%init{
  tokens = "";
  stack = new Stack<Integer>();
  stack.push(0);
  spaceCount = 0;
%init}

SALTO           = (\r|\n|\r\n)+
SALTOLOCO       = (\r|\n|\r\n)*[ \t\f]
STRING          = ("\"" {STRINGCONT} "\"") | ("'" {STRINGCONT} "'")
STRINGCONT      = ( (\\\") | (\\\') | \? | [^\n\\\"\\\'?])*
SEPARADOR       = ":"
OPERADOR        = "+" | "*" | "**" | "-" | "/" | "//" | "%" | "<" | ">" | ">=" | "<=" | "==" | "=" | "!"
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
RESERVADA       = "if" | "else" | "elif" | "print" | "while" | "for" | "not" | "and" | "or"
IDENTIFICADOR   = [a-zA-Z_]([a-zA-Z0-9_])*

%state INDENT, INITIAL

%%
<<EOF>>  { emptyStack(); return 0;}

<YYINITIAL> {
  {SALTOLOCO}     { if(yyline==0){ tokens += "Error de indentación al inicio del archivo.\n"; return 0; } }
  {STRING}      { tokens += "STRING("+yytext() + ") ";  yybegin(INITIAL); }
  {OPERADOR}      { tokens += "OPERADOR("+yytext() + ") "; yybegin(INITIAL);}
  {SEPARADOR}      { tokens += "SEPARADOR("+yytext() + ") "; yybegin(INITIAL);}
  {BOOLEANO}      { tokens += "BOOLEANO("+yytext() + ") ";yybegin(INITIAL); }
  {ENTERO}      { tokens += "ENTERO("+yytext() + ") ";yybegin(INITIAL); }
  {FLOTANTE}      { tokens += "FLOTANTE("+yytext() + ") ";yybegin(INITIAL); }
  {RESERVADA}      { tokens += "RESERVADA("+yytext() + ") ";yybegin(INITIAL); }
  {IDENTIFICADOR}      { tokens += "IDENTIFICADOR("+yytext() + ") "; yybegin(INITIAL);}
}

<INITIAL> {
  [ \t\f]         {  }
  {SALTO}     { tokens += "SALTO\n"; spaceCount=0; yybegin(INDENT); }
  {STRING}      { tokens += "STRING("+yytext() + ") "; }
  {OPERADOR}      { tokens += "OPERADOR("+yytext() + ") "; }
  {SEPARADOR}      { tokens += "SEPARADOR("+yytext() + ") "; }
  {BOOLEANO}      { tokens += "BOOLEANO("+yytext() + ") "; }
  {ENTERO}      { tokens += "ENTERO("+yytext() + ") "; }
  {FLOTANTE}      { tokens += "FLOTANTE("+yytext() + ") "; }
  {RESERVADA}      { tokens += "RESERVADA("+yytext() + ") "; }
  {IDENTIFICADOR}      { tokens += "IDENTIFICADOR("+yytext() + ") "; }
}

<INDENT> {
  {SALTO}     { spaceCount=0; }
  [ ]         { spaceCount++; }
  [\t\f]         { spaceCount+=4; }
  {STRING}      { if(!ident()) return 0; tokens += "STRING("+yytext() + ") ";  yybegin(INITIAL); }
  {OPERADOR}      { if(!ident()) return 0; tokens += "OPERADOR("+yytext() + ") "; yybegin(INITIAL);}
  {SEPARADOR}      { if(!ident()) return 0; tokens += "SEPARADOR("+yytext() + ") "; yybegin(INITIAL);}
  {BOOLEANO}      { if(!ident()) return 0; tokens += "BOOLEANO("+yytext() + ") ";yybegin(INITIAL); }
  {ENTERO}      { if(!ident()) return 0; tokens += "ENTERO("+yytext() + ") ";yybegin(INITIAL); }
  {FLOTANTE}      { if(!ident()) return 0; tokens += "FLOTANTE("+yytext() + ") ";yybegin(INITIAL); }
  {RESERVADA}      { if(!ident()) return 0; tokens += "RESERVADA("+yytext() + ") ";yybegin(INITIAL); }
  {IDENTIFICADOR}      { if(!ident()) return 0; tokens += "IDENTIFICADOR("+yytext() + ") "; yybegin(INITIAL);}
}
.             { tokens += "Caracter ilegal <"+yytext()+">. En la linea "+ (yyline+1)+ ".\n"; return 0; }
