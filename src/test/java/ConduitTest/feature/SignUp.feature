@signup
Feature: Sign up User

    Background: Preconditions:
        Given url apiUrl

    Scenario: Sign up user
        Given def userData = {"email": "brandom12345@gmail.com","password": "123456","username": "Brandom12345"}
        Given path 'users'
        # And request {"user": {"email": #(userData.email),"password": #(userData.password),"username": #(userData.username)}}
        # And request {"user": {"email": #('Test'+userData.email),"password": #(userData.password),"username": #('User'+userData.username)}}
        And request
            """
            {
            "user": {
            "email": #(userData.email),
            "password": #(userData.password),
            "username": #(userData.username)
            }
            }
            """
        When method Post
        Then status 200
