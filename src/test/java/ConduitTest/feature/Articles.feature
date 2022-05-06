
Feature: Articles

    Background: Define URL
        Given url 'https://conduit.productionready.io/api/'
        # Given path 'users/login'
        # And request {"user": {"email": "buho@gmail.com","password": "123456"}}
        # When method Post
        # Then status 200
        # * def token = response.user.token
        * def tokenResponse = callonce read('classpath:helpers/CreateToken.feature'){email: "buho@gmail.com",password: "123456" }
        * def token = tokenResponse.authToken

    Scenario: Create a new artcile
        Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request {"article": {"tagList": [],"title": "BuhoKarate4","description": "Acerca del buho","body": "Karate es bueno"}}
        When method Post
        Then status 200
        And match response.article.title == 'BuhoKarate4'

    @debug
    Scenario: Create and delete article
        Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request {"article": {"tagList": [],"title": "BuhoKarate6","description": "Acerca del buho","body": "Karate es bueno"}}
        When method Post
        Then status 200
        And match response.article.title == 'BuhoKarate6'
        * def article_id = response.article.slug

        Given header Authorization = 'Token ' + token
        Given path 'articles'
        Given params { limit: 10, offset: 0 }
        When method Get
        Then status 200
        And match response.articles[0].title == 'BuhoKarate6'

        Given header Authorization = 'Token ' + token
        Given path 'articles/' + article_id
        When method Delete
        Then status 204

        Given params { limit: 10, offset: 0 }
        Given header Authorization = 'Token ' + token
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != 'BuhoKarate6'


