@hooks
Feature: Hooks

    Background: initialize the hooks
        # * def result = callonce read('classpath:helpers/Dummy.feature')
        # * def username = result.username
        #after hooks
        * def foo = 'Hola'
        * configure afterScenario = function(){karate.call('classpath:helpers/Dummy.feature')}
        # * configure afterFeature = function(){karate.log('afterFeature')}
        * configure afterFeature =
            """
            function(){karate.log('afterFeature')}
            """
    Scenario: first scenario
        * print foo

    Scenario: second scenario
        * print foo

    Scenario Outline: third scenario outline
        * print <bar>

        Examples:
            | bar     |
            | foo + 1 |
            | foo + 2 |