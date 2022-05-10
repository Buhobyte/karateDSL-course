package ConduitTest;

import static org.junit.jupiter.api.Assertions.assertEquals;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;

import org.junit.jupiter.api.Test;
import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;

class ConduitTest {

  // @Karate.Test
  // Karate testAll(){
  // return Karate.run().relativeTo(getClass());
  // }

  @Test
  void testParallel() {

    // Results results =
    // Runner.path("classpath:ConduitTest").tags("@articlesReading,@home,@homework,@hooks")
    Results results = Runner.path("classpath:ConduitTest")
        .tags("@articlesReading,@home,@homework,@hooks")
        .outputCucumberJson(true)
        .karateEnv("qa")
        .parallel(1);
    generateReport(results.getReportDir());
    assertEquals(0, results.getFailCount(), results.getErrorMessages());

  }

  public static void generateReport(String karateOutputPath) {
    Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] { "json" }, true);
    List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
    jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
    Configuration config = new Configuration(new File("target"), "Conduit Application");
    ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
    reportBuilder.generateReports();
  }

}
