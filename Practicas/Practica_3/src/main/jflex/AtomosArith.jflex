package asintactico;
%%
%{
    private ParserLeft parser;

    public NodosArith (java.io.Reader r, ParserLeft p){
    	   this(r);
    	   parser = p;
    }
%}
%class NodosArith
%standalone
%public
%unicode
%%
[0-9]+             { parser.yylval = new ParserLeftVal(yytext()); return parser.NUMBER; }
[ \t\f]*            {  }
\+                { parser.yylval = new ParserLeftVal(yytext()); return parser.SUM; }
\*                { parser.yylval = new ParserLeftVal(yytext()); return parser.MULT; }
\-                { parser.yylval = new ParserLeftVal(yytext()); return parser.MIN; }
\/                { parser.yylval = new ParserLeftVal(yytext()); return parser.DIV; }
.                  { parser.yylval = new ParserLeftVal(yytext()); return parser.ERROR; }
