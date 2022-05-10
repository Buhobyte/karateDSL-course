
Feature: Add likes
    Background: prepare data
        * url apiUrl

    Scenario: add likes
        Given path 'articles',slug,'favorite'
        And request {}
        When method Post
        Then status 200
        * def likesCount = response.article.favoritesCount

