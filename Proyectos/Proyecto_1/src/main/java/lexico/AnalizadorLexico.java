package lexico;
import java.io.*;

public class AnalizadorLexico {
    Flexer lexer;

    public AnalizadorLexico(String archivo){
        try {
            Reader lector = new FileReader(archivo);
            lexer = new Flexer(lector);
        }
        catch(FileNotFoundException ex) {
            System.out.println(ex.getMessage() + " No se encontró el archivo;");
        }
    }

    public void analiza(){
        try{
          lexer.yylex();
        }catch(IOException ioe){
            System.out.println(ioe.getMessage());
        }
    }

    public void tokens(){
        System.out.println(lexer.tokens);
    }

}
