package lexico;
%%
%class Flexer
%public
%standalone
%unicode
SALTO           = (\r|\n|\r\n)+
SPACE           = {SALTO} | [ \t\f]
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
%%
{STRING}      { System.out.print("STRING("+yytext() + ") "); }
{OPERADOR}      { System.out.print("OPERADOR("+yytext() + ") "); }
{SEPARADOR}      { System.out.print("SEPARADOR("+yytext() + ") "); }
{BOOLEANO}      { System.out.print("BOOLEANO("+yytext() + ") "); }
{ENTERO}      { System.out.print("ENTERO("+yytext() + ") "); }
{FLOTANTE}      { System.out.print("FLOTANTE("+yytext() + ") "); }
{RESERVADA}      { System.out.print("RESERVADA("+yytext() + ") "); }
{IDENTIFICADOR}      { System.out.print("IDENTIFICADOR("+yytext() + ") "); }
{SALTO}      { System.out.print("SALTO\n"); }
.             { }
/* tenemos que lanzar un error */
/* .             { throw new Error("Error" + yytext()); } */
