@signuprandom
Feature: Sign up User RANDOMLY

    Background: Preconditions:
        * def dataGenerator = Java.type("helpers.DataGenerator");
        # Si la clase no tiene metodos staticos, se utliza la siguiente sintaxis
        # """
        # function(){
        # var DataGenerator = Java.type("helpers.DataGenerator");
        # var dataRandom = new DataGenerator();
        # return dataRandom.handleRandomUserName();
        # }
        # """
        Given url apiUrl

    Scenario: Sign up user
        * def usernameRandom = dataGenerator.handleRandomUserName();
        * def emailRandom = dataGenerator.handleRandomEmail();
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
