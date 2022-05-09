package ConduitTest;

import static org.junit.jupiter.api.Assertions.assertEquals;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;

import org.junit.jupiter.api.Test;

class ConduitTest {

  // @Karate.Test
  // Karate testAll(){
  // return Karate.run().relativeTo(getClass());
  // }

  @Test
  void testParallel() {

    Results results = Runner.path("classpath:ConduitTest").parallel(1);
    assertEquals(0, results.getFailCount(), results.getErrorMessages());

  }

}
