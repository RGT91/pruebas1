package ejer1;
import java.io.*;
import java.util.Scanner;

public class Test {
  public static void main (String[] args){
    Scanner scanner = new Scanner(System.in);
    scanner.useDelimiter("\\n");
    while(scanner.hasNext()){
      String sentence = scanner.next();
      System.out.println(sentence);
    }
  }
}
