
Feature: Performance create delete article

    Background: Define URL
        Given url apiUrl
        * def articleRequestData = read('classpath:ConduitTest/json/newArticleRequest.json')
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * set articleRequestData.article.title = __gatling.Title
        * set articleRequestData.article.description = __gatling.Description
        * set articleRequestData.article.body = dataGenerator.getRandomArticleValues().body

    Scenario: Create and delete article
        * configure headers = {"Authorization": #('Token '+ __gatling.Token)}
        Given path 'articles'
        And request articleRequestData
        When method Post
        Then status 200
        * def article_id = response.article.slug

# * karate.pause(5000)

# Given path 'articles',article_id
# When method Delete
# Then status 204

