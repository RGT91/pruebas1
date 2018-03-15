package lexico;
%%
%class Flexer
%public
%standalone
%line
%unicode

%{
  protected int levels;
  protected int levels_aux;
  public String tokens;
%}

%init{
  levels = 0;
  levels_aux = 0;
  tokens = "";
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

%state INDENT

%%
<YYINITIAL> {
  {SALTOLOCO}     { if(yyline==0){ tokens += "Error de indentación al inicio del archivo.\n"; return 0; } }
  [ \t\f]         {  }
  {SALTO}     { tokens += "SALTO\n"; yybegin(INDENT); }
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
  {SALTO}     { }
  [ \t\f]         { tokens += "INDENT "; }
  {STRING}      { tokens += "STRING("+yytext() + ") ";  yybegin(YYINITIAL); }
  {OPERADOR}      { tokens += "OPERADOR("+yytext() + ") "; yybegin(YYINITIAL);}
  {SEPARADOR}      { tokens += "SEPARADOR("+yytext() + ") "; yybegin(YYINITIAL);}
  {BOOLEANO}      { tokens += "BOOLEANO("+yytext() + ") ";yybegin(YYINITIAL); }
  {ENTERO}      { tokens += "ENTERO("+yytext() + ") ";yybegin(YYINITIAL); }
  {FLOTANTE}      { tokens += "FLOTANTE("+yytext() + ") ";yybegin(YYINITIAL); }
  {RESERVADA}      { tokens += "RESERVADA("+yytext() + ") ";yybegin(YYINITIAL); }
  {IDENTIFICADOR}      { tokens += "IDENTIFICADOR("+yytext() + ") "; yybegin(YYINITIAL);}
}
.             { tokens += "Caracter ilegal <"+yytext()+">. En la linea "+ (yyline+1)+ ".\n"; return 0; }
