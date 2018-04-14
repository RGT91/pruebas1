package asintactico;
%%
%{
    private Parser parser;

    public Nodos (java.io.Reader r, Parser p){
    	   this(r);
    	   parser = p;
    }
%}
%class Nodos
%standalone
%public
%unicode
%%
a             { parser.yylval = new ParserVal(yytext()); return parser.NODO; }
.             { }
