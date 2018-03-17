package lexico;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.io.Reader;
import java.io.FileReader;
import java.lang.ArrayIndexOutOfBoundsException;

public class AnalizadorLexico {
    Flexer lexer;
    String ourputFile;

    public AnalizadorLexico(String archivo){
        try {
            Reader lector = new FileReader(archivo);
            lexer = new Flexer(lector);
            String[] dirFile = archivo.split("/");
            ourputFile = dirFile[dirFile.length-1].split("\\.")[0];
        }
        catch(FileNotFoundException ex) {
            System.out.println(ex.getMessage() + " No se encontró el archivo;");
        }catch (ArrayIndexOutOfBoundsException aie) {
            System.out.println(aie.getMessage() + " No se encontró el archivo;");
        }
    }

    public void analiza(){
        try (BufferedWriter bw = new BufferedWriter(new FileWriter("out/"+ourputFile+".plx"))) {
          lexer.yylex();
          bw.write(lexer.tokens);
        }catch(IOException ioe){
            System.out.println(ioe.getMessage());
        }
    }

}
