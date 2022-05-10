Feature: Test for the home page

    Background: Define URL:
        Given url 'https://api.realworld.io/api/'

    Scenario: Get all tags
        # Given url 'https://api.realworld.io/api/'
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains ['welcome']
        And match response.tags !contains ['implementation']
        And match response.tags contains any ['frontend', 'backend','welcome']
        # And match response.tags contains only ['welcome']
        And match response.tags == "#array"
        And match each response.tags == "#string"

    Scenario: get 10 articles from the page
        * def timeValidator = read('classpath:helpers/timeValidator.js')
        # Given param limit = 10
        # Given param offset = 0
        Given params {limit: 10, offset: 0}
        # Given url 'https://api.realworld.io/api/'
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles == '#[10]'
        And match response.articlesCount == 33
        And match response.articlesCount != 8
        And match response == {articles: "#array", articlesCount: 33}
        And match response == {articles: "#[10]", articlesCount: 33}
        And match response.articles[0].createdAt contains '2022'
        And match response.articles[*].favoritesCount contains 0
        And match response..bio contains null
        And match each response..following == "#boolean"
        And match each response..following == false
        And match each response..favoritesCount == "#number"
        And match each response..bios == "#string"
        And match each response.articles ==
            """
            {
                "slug": "#string",
                "title": "#string",
                "description": "#string",
                "body": "#string",
                "tagList": "#[]",
                "createdAt": "#? timeValidator(_)",
                "updatedAt": "#? timeValidator(_)",
                "favorited": "#boolean",
                "favoritesCount": "#number",
                "author": {
                    "username": "#string",
                    "bio": "##string",
                    "image": "#string",
                    "following": "#boolean"
                }
            }
            """
    @home
    Scenario: Add Likes
        Given params {limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        * def favoritesCount = response.articles[0].favoritesCount
        * def article = response.articles[0]

        # * if (favoritesCount == 0) {karate.call('classpath:helpers/AddLikes.feature',article)}

        *  def result = favoritesCount == 0 ? karate.call('classpath:helpers/AddLikes.feature',article).likesCount : favoritesCount

        Given params {limit: 10, offset: 0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].favoritesCount == result