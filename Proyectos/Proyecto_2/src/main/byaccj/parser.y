%{
  import java.lang.Math;
  import java.io.*;
%}

%token<sval> ENDMARKER SALTO INDENTA DEINDENTA IDENTIFICADOR ENTERO CADENA REAL BOOLEANO ELSE IF PRINT WHILE SEPARADOR AND OR NOT

/* Gramática con recursión izquierda */
%%
// file_input: (SALTO | stmt)* ENDMARKER
input : ENDMARKER                   { System.out.println("[OK]");}
  | file_input ENDMARKER            { System.out.println("[OK]");}
  ;

// file_input: (SALTO | stmt)*
file_input: SALTO                   { System.out.println("[OK]");}
  | stmt                   { System.out.println("[OK]");}
  | SALTO file_input                { System.out.println("[OK]");}
  | stmt file_input                   { System.out.println("[OK]");}
  ;

// stmt: simple_stmt | compound_stmt
stmt: simple_stmt                   { System.out.println("[OK]");}
  | compound_stmt                   { System.out.println("[OK]");}
  ;

// simple_stmt: small_stmt SALTO
simple_stmt: small_stmt SALTO                   { System.out.println("[OK]");}
  ;

// small_stmt: expr_stmt | print_stmt
small_stmt: expr_stmt                   { System.out.println("[OK]");}
  | print_stmt                   { System.out.println("[OK]");}
  ;

// expr_stmt: test '=' test
expr_stmt: test EQ test                   { System.out.println("[OK]");}
  ;

// print_stmt: 'print' test
print_stmt: PRINT test                   { System.out.println("[OK]");}
  ;

// compound_stmt: if_stmt | while_stmt
compound_stmt: if_stmt                   { System.out.println("[OK]");}
  | while_stmt                   { System.out.println("[OK]");}
  ;

// if_stmt: 'if' test ':' suite ['else' ':' suite]
if_stmt: IF test SEPARADOR suite                   { System.out.println("[OK]");}
  | IF test SEPARADOR suite ELSE SEPARADOR suite                   { System.out.println("[OK]");}
  ;

// while_stmt: WHILE test ':' suite
while_stmt: WHILE test SEPARADOR suite                   { System.out.println("[OK]");}
  ;

// suite: simple_stmt | SALTO INDENTAA stmt+ DEINDENTAA
suite: simple_stmt                   { System.out.println("[OK]");}
  | SALTO INDENTA stmtM DEINDENTA                   { System.out.println("[OK]");}
  ;

// stmt+
stmtM : stmt                   { System.out.println("[OK]");}
  | stmt stmtM                   { System.out.println("[OK]");}
  ;

// test: or_test
test: or_test                   { System.out.println("[OK]");}
  ;

// or_test: and_test ('or' and_test)*
or_test: and_test                   { System.out.println("[OK]");}
  | and_test OR or_test                   { System.out.println("[OK]");}
  ;

// and_test: not_test ('and' not_test)*
and_test: not_test                   { System.out.println("[OK]");}
  | not_test AND and_test                   { System.out.println("[OK]");}
  ;

// not_test: 'not' not_test | comparison
not_test: comparison                   { System.out.println("[OK]");}
  | NOT not_test                   { System.out.println("[OK]");}
  ;

// comparison: expr (comp_op expr)*
// comp_op: '<'|'>'|'=='|'>='|'<='|'!='
comparison: expr                   { System.out.println("[OK]");}
  | expr COMPARADOR comparison                   { System.out.println("[OK]");}
  ;

//expr: term (('+'|'-') term)*
expr: term                   { System.out.println("[OK]");}
  | term '+' expr                   { System.out.println("[OK]");}
  | term '-' expr                   { System.out.println("[OK]");}
  ;

// term: factor (('*'|'/'|'%'|'//') factor)*
term: factor                   { System.out.println("[OK]");}
  | factor '*' term                   { System.out.println("[OK]");}
  | factor '/' term                   { System.out.println("[OK]");}
  | factor '%' term                   { System.out.println("[OK]");}
  | factor '//' term                   { System.out.println("[OK]");}
  ;

// factor: ('+'|'-') factor | power
factor: factor                   { System.out.println("[OK]");}
  | '+' factor                   { System.out.println("[OK]");}
  | '-' factor                   { System.out.println("[OK]");}
  | power                   { System.out.println("[OK]");}
  ;

// power: atom ['**' factor]
power: atom                   { System.out.println("[OK]");}
  | atom '**' factor                   { System.out.println("[OK]");}
  ;

// atom: IDENTIFICADOR | ENTERO | CADENA | REAL | BOOLEANO | '(' test ')'
atom: IDENTIFICADOR                   { System.out.println("[OK]");}
  | ENTERO                   { System.out.println("[OK]");}
  | CADENA                   { System.out.println("[OK]");}
  | REAL                   { System.out.println("[OK]");}
  | BOOLEANO                   { System.out.println("[OK]");}
  | '(' test ')'                   { System.out.println("[OK]");}
  ;
%%
/* Referencia a analizador léxico */
private Flexer lexer;

private int yylex () {
    int yyl_return = -1;
    try {
      yyl_return = lexer.yylex();
    }
    catch (IOException e) {
      System.err.println("IO error :"+e);
    }
    return yyl_return;
}

/* Función para reportar error */
public void yyerror (String error) {
    System.err.println ("[ERROR]  " + error);
    System.err.println ("[ERROR]  " + lexer.yytext());
    System.exit(1);
}

/* Constructor */
public Parser(Reader r) {
    lexer = new Flexer(r, this);
}

/* Creación del parser e inicialización del reconocimiento */
public static void main(String args[]) throws IOException {
    Parser parser = new Parser(new FileReader("resources/fizzbuzz.py"));
    parser.yydebug = true;
    parser.yyparse();
}
