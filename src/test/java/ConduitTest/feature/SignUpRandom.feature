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
        * def usernameRandom = dataGenerator.getRandomUserName();
        * def emailRandom = dataGenerator.getRandomEmail();

    Scenario: Sign up user
        * def jsFuntion =
            """
            function(){
            var DataGenerator = Java.type("helpers.DataGenerator");
            var generator = new DataGenerator();
            return generator;
            }
            """
        * def jsFuntion2 = call jsFuntion
        * def randomEmail2 = jsFuntion2.getRandomEmail2();
        Given path 'users'
        And request
            """
            {
                "user": {
                    "email": "#(randomEmail2)",
                    "password": "123456",
                    "username": "#(usernameRandom)"
                }
            }
            """
        When method Post
        Then status 200
        And match response ==
            """
            {
                "user": {
                    "email": "#(randomEmail2)",
                    "username": "#(usernameRandom)",
                    "bio": "##string",
                    "image": "##string",
                    "token": "#string"
                }
            }
            """

    Scenario Outline: Sign up user validate errors with outline - examples
        Given path 'users'
        And request
            """
            {
                "user": {
                    "email": "<email>",
                    "password": "<password>",
                    "username": "<username>"
                }
            }
            """
        When method Post
        Then status 422
        And match response == <errorResponse>

        Examples:
            | email                | password | username          | errorResponse                                      |
            | #(emailRandom)       | 123456   | buho              | {"errors":{"username":["has already been taken"]}} |
            | brandom123@gmail.com | 123456   | #(usernameRandom) | {"errors":{"email":["has already been taken"]}}    |
