package lexico;
import java.io.*;

public class Test {

    public static void main (String[] args){
        AnalizadorLexico al = new AnalizadorLexico("resources/fizzbuzz.py");
        al.analiza();
        al.tokens();
        al = new AnalizadorLexico("resources/fz_error_lexema.py");
        al.analiza();
        al.tokens();
    }
}
