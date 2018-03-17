package lexico;

public class Test {

  public static void main (String[] args){
    AnalizadorLexico al = null;
    if(args.length==0){
      al = new AnalizadorLexico("resources/fizzbuzz.py");
    }else{
      al = new AnalizadorLexico(args[0]);
    }
    al.analiza();
  }
}
