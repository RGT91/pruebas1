package lexico;
%%
%class Flexer
%public
%standalone
%unicode

%{
  int levels = 0;
  int levels_aux = 0;
%}


SALTO           = (\r|\n|\r\n)+
STRING          = ("\"" {STRINGCONT} "\"") | ("'" {STRINGCONT} "'")
STRINGCONT      = ( (\\\") | \? | [^\\\"?])*
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

%state INDENT

%%
<YYINITIAL> {
  {SALTO}     { levels_aux=0;System.out.print("SALTO\n"); yybegin(INDENT); }
  {STRING}      { System.out.print("STRING("+yytext() + ") "); }
  {OPERADOR}      { System.out.print("OPERADOR("+yytext() + ") "); }
  {SEPARADOR}      { System.out.print("SEPARADOR("+yytext() + ") "); }
  {BOOLEANO}      { System.out.print("BOOLEANO("+yytext() + ") "); }
  {ENTERO}      { System.out.print("ENTERO("+yytext() + ") "); }
  {FLOTANTE}      { System.out.print("FLOTANTE("+yytext() + ") "); }
  {RESERVADA}      { System.out.print("RESERVADA("+yytext() + ") "); }
  {IDENTIFICADOR}      { System.out.print("IDENTIFICADOR("+yytext() + ") "); }
}
<INDENT> {
  {SALTO}     { }
  [ \t\f]         { System.out.print("INDENT "); }
  {STRING}      { System.out.print("STRING("+yytext() + ") ");  yybegin(YYINITIAL); }
  {OPERADOR}      { System.out.print("OPERADOR("+yytext() + ") "); yybegin(YYINITIAL);}
  {SEPARADOR}      { System.out.print("SEPARADOR("+yytext() + ") "); yybegin(YYINITIAL);}
  {BOOLEANO}      { System.out.print("BOOLEANO("+yytext() + ") ");yybegin(YYINITIAL); }
  {ENTERO}      { System.out.print("ENTERO("+yytext() + ") ");yybegin(YYINITIAL); }
  {FLOTANTE}      { System.out.print("FLOTANTE("+yytext() + ") ");yybegin(YYINITIAL); }
  {RESERVADA}      { System.out.print("RESERVADA("+yytext() + ") ");yybegin(YYINITIAL); }
  {IDENTIFICADOR}      { System.out.print("IDENTIFICADOR("+yytext() + ") "); yybegin(YYINITIAL);}
}
.             { }
/* tenemos que lanzar un error */
/* .             { throw new Error("Error" + yytext()); } */
