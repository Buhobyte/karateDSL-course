
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
        And match response.tags == "#array"
        And match each response.tags == "#string"

    Scenario: get 10 articles from the page
        # Given param limit = 10
        # Given param offset = 0
        Given params {limit: 10, offset: 0}
        # Given url 'https://api.realworld.io/api/'
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles == '#[3]'
        And match response.articlesCount == 3