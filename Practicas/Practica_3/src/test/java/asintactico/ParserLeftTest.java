package asintactico;

import junit.framework.TestCase;
import static org.assertj.core.api.Assertions.*;
import java.io.File;
import java.io.*;

public class ParserLeftTest extends TestCase {
  ParserLeft parser;

  protected void setUp() throws Exception {
    super.setUp();
  }

  protected void tearDown() throws Exception {
    super.tearDown();
  }

  public final void testFail1() {
    try{
      parser = new ParserLeft(new FileReader("src/main/resources/test_fail_1.txt"));
      parser.yyparse();
    }catch (Exception e) {
      fail(e.toString());
    }
  }

  public final void testFail2() {
    try{
      parser = new ParserLeft(new FileReader("src/main/resources/test_fail_2.txt"));
      parser.yyparse();
    }catch (Exception e) {
      fail(e.toString());
    }
  }

  public final void testFail3() {
    try{
      parser = new ParserLeft(new FileReader("src/main/resources/test_fail_3.txt"));
      parser.yyparse();
    }catch (Exception e) {
      fail(e.toString());
    }
  }

  public final void testFail4() {
    try{
      parser = new ParserLeft(new FileReader("src/main/resources/test_fail_4.txt"));
      parser.yyparse();
    }catch (Exception e) {
      fail(e.toString());
    }
  }

  public final void testSuccess1() {
    try{
      parser = new ParserLeft(new FileReader("src/main/resources/test_success_1.txt"));
      parser.yyparse();
    }catch (Exception e) {
      fail(e.toString());
    }
  }

  public final void testSuccess2() {
    try{
      parser = new ParserLeft(new FileReader("src/main/resources/test_success_2.txt"));
      parser.yyparse();
    }catch (Exception e) {
      fail(e.toString());
    }
  }

  public final void testSuccess3() {
    try{
      parser = new ParserLeft(new FileReader("src/main/resources/test_success_3.txt"));
      parser.yyparse();
    }catch (Exception e) {
      fail(e.toString());
    }
  }

  public final void testSuccess4() {
    try{
      parser = new ParserLeft(new FileReader("src/main/resources/test_success_4.txt"));
      parser.yyparse();
    }catch (Exception e) {
      fail(e.toString());
    }
  }

  public final void testSuccess5() {
    try{
      parser = new ParserLeft(new FileReader("src/main/resources/test_success_5.txt"));
      parser.yyparse();
    }catch (Exception e) {
      fail(e.toString());
    }
  }

  public final void testSuccessMix() {
    try{
      parser = new ParserLeft(new FileReader("src/main/resources/test_success_mix_1.txt"));
      parser.yyparse();
    }catch (Exception e) {
      fail(e.toString());
    }
  }
}
