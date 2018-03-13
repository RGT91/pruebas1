package lexico;
import java.io.*;

public class Test {

    public static void main (String[] args){
        AnalizadorLexico al = new AnalizadorLexico("resources/fizzbuzz.py");
        al.analiza();
        al = new AnalizadorLexico("resources/fz_error_cadena.py");
        al.analiza();
        al = new AnalizadorLexico("resources/fz_error_identacion.py");
        al.analiza();
        al = new AnalizadorLexico("resources/fz_error_lexema.py");
        al.analiza();
        al = new AnalizadorLexico("resources/fz_error_inicio.py");
        al.analiza();
    }
}
