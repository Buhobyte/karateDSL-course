@articles2
Feature: Articles With Karate-configured

    Background: Define URL
        Given url apiUrl

    Scenario: Create a new artcile
        Given path 'articles'
        And request {"article": {"tagList": [],"title": "BuhoKarate4","description": "Acerca del buho","body": "Karate es bueno"}}
        When method Post
        Then status 200
        And match response.article.title == 'BuhoKarate4'

    @debug
    Scenario: Create and delete article
        Given path 'articles'
        And request {"article": {"tagList": [],"title": "BuhoKarate6","description": "Acerca del buho","body": "Karate es bueno"}}
        When method Post
        Then status 200
        And match response.article.title == 'BuhoKarate6'
        * def article_id = response.article.slug

        Given path 'articles'
        Given params { limit: 10, offset: 0 }
        When method Get
        Then status 200
        And match response.articles[0].title == 'BuhoKarate6'

        Given path 'articles/' + article_id
        When method Delete
        Then status 204

        Given params { limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != 'BuhoKarate6'


