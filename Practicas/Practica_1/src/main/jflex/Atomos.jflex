package testmaven;
%%
%class Aléxico
%public
%standalone
%unicode
COMMENT = "--"[^\n\r\"]+ | "{-" . "-}"
PUNTO   = \.
ENTERO  = [1-9][0-9]* | 0+
ID_JAVA = [:jletter:] [:jletterdigit:]*
%%
{ENTERO}      { System.out.print("ENTERO("+yytext() + ")"); }
{ID_JAVA}     { System.out.print("ID_JAVA("+yytext() + ")"); }
.             { }
