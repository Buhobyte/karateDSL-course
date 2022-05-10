@workdb
Feature: work with DB

    Background: coneect to DB
        * def dbHandler = Java.type("helpers.DbHandler")

    @database

    Scenario: Seed database with a new job
        * def firstUser = dbHandler.getUsers("Byron")
        * print firstUser
        And match firstUser ==
            """
            {
                "password": "#string",
                "__v": "#number",
                "name": "#string",
                "_id": {
                    "$oid": "#string"
                },
                "email": "#string"
            }
            """