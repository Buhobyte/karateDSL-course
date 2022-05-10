# karateDSL-course

### Command Run

```
mvn test -Dkarate.options="--tags @workdb" -Dkarate.env="qa"
```

## AfterFeature

>note that afterFeature will not work with the JUnit runners

You need use:
```java
package ConduitTest;

import static org.junit.jupiter.api.Assertions.assertEquals;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

// import com.intuit.karate.junit5.Karate;

class ConduitTest {

  // @Karate.Test
  // Karate testAll(){
  // return Karate.run().relativeTo(getClass());
  // }
  
  @Test
  void testParallel() {

    Results results = Runner.path("classpath:ConduitTest").parallel(2);
    assertEquals(0, results.getFailCount(), results.getErrorMessages());

  }

}
```

### Create project

```
mvn archetype:generate \
-DarchetypeGroupId=com.intuit.karate \
-DarchetypeArtifactId=karate-archetype \
-DarchetypeVersion=1.1.0 \
-DgroupId=com.buhobyte \
-DartifactId=KarateCourse
```