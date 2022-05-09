@articlesReading
Feature: Articles read other files

    Background: Define URL
        Given url apiUrl
        * def articleRequestData = read('classpath:ConduitTest/json/newArticleRequest.json')
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * set articleRequestData.article.title = dataGenerator.getRandomArticleValues().title
        * set articleRequestData.article.description = dataGenerator.getRandomArticleValues().description
        * set articleRequestData.article.body = dataGenerator.getRandomArticleValues().body
        * print articleRequestData

    Scenario: Create a new artcile
        Given path 'articles'
        And request articleRequestData
        When method Post
        Then status 200
        And match response.article.title == articleRequestData.article.title

    @debug
    Scenario: Create and delete article
        Given path 'articles'
        And request articleRequestData
        When method Post
        Then status 200
        And match response.article.title == articleRequestData.article.title
        * def article_id = response.article.slug

        Given path 'articles'
        Given params { limit: 10, offset: 0 }
        When method Get
        Then status 200
        And match response.articles[0].title == articleRequestData.article.title

        Given path 'articles/' + article_id
        When method Delete
        Then status 204

        Given params { limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != articleRequestData.article.title


