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
        * def usernameRandom = dataGenerator.getRandomUserName();
        * def emailRandom = dataGenerator.getRandomEmail();
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
