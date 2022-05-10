
package ConduitTest.performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class PerformTest extends Simulation {

  val protocol = karateProtocol("/api/articles/{article_id}" -> Nil )

//   protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")
  protocol.runner.karateEnv("qa")

  val createArticle = scenario("createArticle").exec(karateFeature("classpath:ConduitTest/performance/createArticle.feature"))
//   val delete = scenario("delete").exec(karateFeature("classpath:mock/cats-delete.feature@name=delete"))

  setUp(
    createArticle.inject(atOnceUsers(3)).protocols(protocol)
  )

}