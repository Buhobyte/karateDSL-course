
Feature: Performance create delete article

    Background: Define URL
        Given url apiUrl
        * def articleRequestData = read('classpath:ConduitTest/json/newArticleRequest.json')
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * set articleRequestData.article.title = dataGenerator.getRandomArticleValues().title
        * set articleRequestData.article.description = dataGenerator.getRandomArticleValues().description
        * set articleRequestData.article.body = dataGenerator.getRandomArticleValues().body
        * print articleRequestData

    Scenario: Create and delete article
        Given path 'articles'
        And request articleRequestData
        When method Post
        Then status 200
        * def article_id = response.article.slug

        * karate.pause(5000)

        Given path 'articles',article_id
        When method Delete
        Then status 204

