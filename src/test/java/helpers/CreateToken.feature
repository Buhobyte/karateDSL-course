
Feature: Create Token

    Scenario: Create a new token
        Given url 'https://conduit.productionready.io/api/'
        Given path 'users/login'
        And request {"user": {"email": "#(userEmail)","password": "#(userPassword)"}}
        When method Post
        Then status 200
        * def authToken = response.user.token