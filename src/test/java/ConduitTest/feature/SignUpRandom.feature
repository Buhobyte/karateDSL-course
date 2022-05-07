@signuprandom
Feature: Sign up User RANDOMLY

    Background: Preconditions:
        * def dataGenerator = Java.type("helpers.DataGenerator")
        Given url apiUrl

    Scenario: Sign up user
        * def usernameRandom = dataGenerator
        * def emailRandom = dataGenerator
        Given path 'users'
        And request
            """
            {
            "user": {
            "email": #(emailRandom),
            "password": "123456",
            "username": #(usernameRandom)
            }
            }
            """
        When method Post
        Then status 200
