package ejer1;
import java.io.*;
import java.util.Scanner;
import java.util.List;
import java.util.ArrayList;
import java.util.Stack;

abstract class State{
  abstract String label();

  abstract int index();

  abstract boolean isError();
}

class ErrorState extends State{
  public String label(){
    return "QE";
  }

  public int index(){
    return -1;
  }

  public boolean isError(){
    return true;
  }
}

class StateInt extends State{
  public int q;

  public StateInt(int q){
    this.q = q;
  }

  public String label(){
    return "Q "+q;
  }

  public int index(){
    return q;
  }

  public boolean isError(){
    return false;
  }
}

class KeyInt{
  public State q;
  public int i;

  public KeyInt(){
    this.q = new ErrorState();
    i = 1;
  }

  public KeyInt(State q, int i){
    this.q = q;
    this.i = i;
  }
}

abstract class Delta{
  abstract State trans(State q, char a);
}

class DeltaEje1 extends Delta{
  public State q0 = new StateInt(0);
  public State q1 = new StateInt(1);
  public State q2 = new StateInt(2);
  public State q3 = new StateInt(3);
  public State q4 = new StateInt(4);
  public State q5 = new StateInt(5);

  public DeltaEje1(){}

  public State trans(State q, char a){
    if(!q.isError()){
      if(q.index() == q0.index() && a=='a') return q1;
      if(q.index() == q0.index() && a=='c') return q5;
      if(q.index() == q1.index() && a=='b') return q2;
      if(q.index() == q2.index() && a=='a') return q3;
      if(q.index() == q2.index() && a=='c') return q5;
      if(q.index() == q3.index() && a=='b') return q4;
      if(q.index() == q4.index() && a=='a') return q3;
      if(q.index() == q4.index() && a=='c') return q5;
    }
    return new ErrorState();
  }
}

abstract class FiniteDet{
  public Delta d;

  public FiniteDet(Delta d){
    this.d = d;
  }

  public State nextState(State q, char a){
    return d.trans(q,a);
  }

  abstract boolean isFinal(State q);
}

class FailCheckException extends Exception{
  public FailCheckException(){
    super("Error cadena mal formada");
  }
}

interface AltOutput{
  String regExp(State q);

  String getOutput(String wd) throws FailCheckException;
}

class FiniteAutomaton extends FiniteDet implements AltOutput{
  State q0;

  public FiniteAutomaton(int q, Delta d){
    super(d);
    this.q0 = new StateInt(q);
  }

  public FiniteAutomaton(State q, Delta d){
    super(d);
    this.q0 = q;
  }

  public boolean isFinal(State q){
    return !q.label().equals("QE") && (q.index() == (new StateInt(2)).index() || q.index() == (new StateInt(5)).index());
  }

  public String regExp(State q){
    if(q.index() == (new StateInt(2)).index()) return "ab";
    if(q.index() == (new StateInt(5)).index()) return "(ab)*c";
    return "";
  }

  public String getOutput(String wd) throws FailCheckException{
    List<State> acceptedPartial = new ArrayList<State>();
    Stack<KeyInt> stored;
    // por defecto ya son falsos
    int wdLength = wd.length();
    boolean[][] failedPrev = new boolean[6][wdLength+1];
    String newWd = "";
    State q;
    boolean flag = true;
    int i = 0;
    while(flag){
      q= q0;
      stored = new Stack<KeyInt>();
      stored.push(new KeyInt());

      do{
        if(failedPrev[q.index()][i]) break;
        if(isFinal(q)) stored = new Stack<KeyInt>();
        stored.push(new KeyInt(q,i));
        q = nextState(q, wd.charAt(i));
        i++;
      } while (i<wdLength && !nextState(q, wd.charAt(i)).isError());
      stored.push(new KeyInt(q,i));
      for (KeyInt k = stored.pop(); !stored.empty(); k = stored.pop()) {
        if(!isFinal(k.q)){
          if(k.q.isError()){
            throw new FailCheckException();
          }
          failedPrev[k.q.index()][k.i] = true;
        }else{
          if(k.i >= wdLength) flag = false;
          i = k.i;
          acceptedPartial.add(k.q);
          break;
        }
      }
    }
    for (State fq : acceptedPartial) {
      newWd += regExp(fq) + " ";
    }
    return newWd;
  }
}

public class Test {
  public static void main (String[] args){
    AltOutput fin = new FiniteAutomaton(0, new DeltaEje1());
    Scanner scanner = new Scanner(System.in);
    scanner.useDelimiter("\\n");
    String sentence;
    String patterns;
    while(scanner.hasNext()){
      sentence = scanner.nextLine();
      System.out.println("Cadena: "+sentence);
      try {
        patterns = fin.getOutput(sentence);
        System.out.println("OK: "+patterns);
      }catch (FailCheckException e) {
        System.out.println("Error: "+e.getMessage());
      }catch (Exception e) {
        System.out.println("Error: "+e.getMessage());
      }
    }
  }
}
