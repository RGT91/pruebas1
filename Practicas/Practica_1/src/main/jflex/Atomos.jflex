package testmaven;
%%
%class Aléxico
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
ENTERO  = [1-9][0-9]* | 0+
ID_JAVA = [:jletter:] [:jletterdigit:]*
%%
{ENTERO}      { System.out.print("ENTERO("+yytext() + ")"); }
{ID_Reserved}     { System.out.print("ID_Reserved("+yytext() + ")"); }
{ID_JAVA}     { System.out.print("ID_JAVA("+yytext() + ")"); }
{COMMENT}     { System.out.print("COMMENT("+yytext() + ")"); }
.             { }
