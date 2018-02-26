package testmaven;
%%
%class AléxicoHaskell
%public
%standalone
%unicode
COMMENT = ("--"[^\n\r\"]+) | ("{-\n" [^]* "-}")
ID_RESERVED   = {CASEID} | {CLASSID} | {DATAID} | {DEFAULTID} | {DERIVINGID} | {DOID} | {ELSEID} | {IFID} | {IMPORTID} | {INID} | {INFIXID} | {INFIXLID} | {INFIXRID} | {INSTANCEID} | {LETID} | {MODULEID} | {NEWTYPEID} | {OFID} | {THENID} | {TYPEID} | {WHEREID} | {WILDCARDID} | {FORID}
CASEID        = "case"
CLASSID       = "class"
DATAID        = "data"
DEFAULTID     = "default"
DERIVINGID    = "deriving"
DOID          = "do"
ELSEID        = "else"
IFID          = "if"
IMPORTID      = "import"
INID          = "in"
INFIXID       = "infix"
INFIXLID      = "infixl"
INFIXRID      = "infixr"
INSTANCEID    = "instance"
LETID         = "let"
MODULEID      = "module"
NEWTYPEID     = "newtype"
OFID          = "of"
THENID        = "then"
TYPEID        = "type"
WHEREID       = "where"
WILDCARDID    = "_"
FORID         = "for"
PUNTO   = \.
ASCIIDIGIT    = [0-9]
DIGIT         = {ASCIIDIGIT}
OCTIT         = [0-7]
HEXIT         = {DIGIT} | [A-Fa-f]
DECIMAL       = {DIGIT}+
OCTAL         = {OCTIT}+
HEXADECIMAL   = {HEXIT}+
ENTERO       = {DECIMAL} | "0o" {OCTAL} | "0O" {OCTAL} | "0x" {HEXADECIMAL} | "0X" {HEXADECIMAL}
FLOTANTE         = {DECIMAL} "." {DECIMAL} {EXPONENTE}? | {DECIMAL} {EXPONENTE}?
EXPONENTE      = ("e" | "E") ("+" | "-")? {DECIMAL}
ID_HASKELL = [:jletter:] [:jletterdigit:]*
%%
{ENTERO}      { System.out.print("ENTERO("+yytext() + ")"); }
{FLOTANTE}      { System.out.print("FLOTANTE("+yytext() + ")"); }
{ID_RESERVED}     { System.out.print("ID_Reserved("+yytext() + ")"); }
{ID_HASKELL}     { System.out.print("ID_HASKELL("+yytext() + ")"); }
{COMMENT}     { System.out.print("COMMENT("+yytext() + ")"); }
.             { }
