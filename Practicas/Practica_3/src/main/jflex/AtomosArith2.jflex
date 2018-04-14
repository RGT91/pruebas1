package asintactico;
%%
%{
    private ParserRight parser;

    public NodosArith2 (java.io.Reader r, ParserRight p){
    	   this(r);
    	   parser = p;
    }
%}
%class NodosArith2
%standalone
%public
%unicode
%%
[0-9]+             { parser.yylval = new ParserRightVal(yytext()); return parser.NUMBER; }
[ \t\f]*            {  }
\+                { parser.yylval = new ParserRightVal(yytext()); return parser.SUM; }
\*                { parser.yylval = new ParserRightVal(yytext()); return parser.MULT; }
\-                { parser.yylval = new ParserRightVal(yytext()); return parser.MIN; }
\/                { parser.yylval = new ParserRightVal(yytext()); return parser.DIV; }
.                  { parser.yylval = new ParserRightVal(yytext()); return parser.ERROR; }
