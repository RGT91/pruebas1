/********************************************************************************
**  Analizador léxico para p, subconjunto de Python.	                       **
*********************************************************************************/
package asintactico;
%%
%public
%class Flexer
%debug
%byaccj
%line
%unicode
%{
    private Parser yyparser;

    public Flexer(java.io.Reader r, Parser parser){
    	   this(r);
    	   yyparser = parser;
    }
%}

ENTERO			= 0+ | [0-9]+
REAL			= {ENTERO}? \. {ENTERO}?
IDENTIFICADOR     	= ([:letter:] | "_" )([:letter:] | "_" | [0-9])*
BOOLEANO	        = ("True" | "False")
%%
{REAL}				  { return Parser.REAL;}
{ENTERO}			  { return Parser.ENTERO;}
{BOOLEANO}                        { return Parser.BOOLEANO;}
{IDENTIFICADOR}			  { return Parser.IDENTIFICADOR;}
[^]                               {}
