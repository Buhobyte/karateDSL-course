
package ConduitTest.performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class PerformTest extends Simulation {

  val protocol = karateProtocol("/api/articles/{article_id}" -> Nil )

//   protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")
  protocol.runner.karateEnv("qa")

  // strategy circular() restart to init data from articles.csv
  val csvFeeder = csv("articles.csv").circular()

  val createArticle = scenario("createArticle").feed(csvFeeder).exec(karateFeature("classpath:ConduitTest/performance/createArticle.feature"))
//   val delete = scenario("delete").exec(karateFeature("classpath:mock/cats-delete.feature@name=delete"))

  setUp(
    createArticle.inject(
        atOnceUsers(1),
        nothingFor(4),
        // atOnceUsers(10),
        // rampUsers(10).during(5),
        constantUsersPerSec(1).during(3),
        // constantUsersPerSec(2).during(10),
        // // constantUsersPerSec(2).during(10).randomized(),
        // rampUsersPerSec(2).to(10).during(20),
        // // rampUsersPerSec(10).to(20).during(10).randomized(),
        // nothingFor(5),
        // // stressPeakUsers(1000).during(20),
        // constantUsersPerSec(1).during(5),
      ).protocols(protocol)
  )

}