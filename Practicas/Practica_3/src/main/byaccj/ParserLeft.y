%{
  import java.lang.Math;
  import java.io.*;
%}

%token<sval> NUMBER MIN ERROR
%type<ival> input T E INTEGER

%left SUM MIN
%left MULT DIV

%%
input : ERROR { yyerror($1); }
  | E ERROR { yyerror($2); }
  | E     {$$ = $1; System.out.println("[OK] "+ $$  );}
;

E : E SUM T {$$ = $1 + $3;}
  | E MIN T {$$ = $1 - $3;}
  | T
;

T: T MULT INTEGER {$$ = $1 * $3;}
  | T DIV INTEGER {$$ = $1 / $3;}
  | INTEGER {$$ = $1;}
;

INTEGER : NUMBER {$$ = new Integer($1);}
  | MIN NUMBER {$$ = new Integer($1 + $2);}
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
