package testmaven;
%%
%public
%standalone
%unicode
PUNTO   = \.
ENTERO  = [1-9][0-9]* | 0+
%%
{ENTERO}        { System.out.print("ENTERO("+yytext() + ")"); }
{ENTERO}? {PUNTO} {ENTERO} | {ENTERO} {PUNTO} {ENTERO}?
                { System.out.print("REAL(" + yytext() + ")" ); }
.               { }
