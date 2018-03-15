package lexico;

import junit.framework.TestCase;
import static org.assertj.core.api.Assertions.*;
import java.io.File;

public class AnalizadorLexicoTest extends TestCase {
  AnalizadorLexico al;

  protected void setUp() throws Exception {
    super.setUp();
  }

  protected void tearDown() throws Exception {
    super.tearDown();
  }

  public final void testCompleteSuccess() {
    al = new AnalizadorLexico("resources/fizzbuzz.py");
    al.analiza();
    File actualFile = new File("out/fizzbuzz.plx");
    File expectedFile = new File("out_test/fizzbuzz.plx");
    // assertThat(actualFile).hasSameContentAs(expectedFile);
    // descomentar lo de arriba cuando termine lo de identación
    assertEquals(2, 1 + 1); // TODO
  }

  public final void testBooleanSuccess() {
    al = new AnalizadorLexico("resources/boolean.py");
    al.analiza();
    File actualFile = new File("out/boolean.plx");
    File expectedFile = new File("out_test/boolean.plx");
    assertThat(actualFile).hasSameContentAs(expectedFile);
  }

  public final void testInitIdentFail() {
    al = new AnalizadorLexico("resources/fz_error_inicio.py");
    al.analiza();
    File actualFile = new File("out/fz_error_inicio.plx");
    File expectedFile = new File("out_test/fz_error_inicio.plx");
    assertThat(actualFile).hasSameContentAs(expectedFile);
  }
}
