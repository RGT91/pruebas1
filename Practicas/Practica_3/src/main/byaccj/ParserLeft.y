%{
  import java.lang.Math;
  import java.io.*;
%}

%token MULT DIV SUM MIN
%token<ival> E F NUMBER
%type<ival> input T

%left MULT DIV
%left SUM MIN

%%
input : T {$$ = $1; System.out.println("[OK] "+ $$  );}
      |       { System.out.println("[Nada]");}
;

T : T SUM NUMBER {$$ = $1 + $3;}
     | T MULT NUMBER {$$ = $1 + $3;}
     | T MIN NUMBER {$$ = $1 + $3;}
     | T DIV NUMBER {$$ = $1 + $3;}
     | NUMBER {$$ = $1;}

%%
/* Referencia a analizador léxico */
private NodosArith lexer;

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
    //System.exit(0);
}

/* Constructor */
public ParserLeft(Reader r) {
    lexer = new NodosArith(r, this);
}

/* Creación del parser e inicialización del reconocimiento */
public static void main(String args[]) throws IOException {
    ParserLeft parser = new ParserLeft(new FileReader(args[0]));
    parser.yyparse();
}
