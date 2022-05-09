Feature: Dummy Feature

    Scenario: Dummy Scenario
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * def username = dataGenerator.getRandomUserName()
        * print username