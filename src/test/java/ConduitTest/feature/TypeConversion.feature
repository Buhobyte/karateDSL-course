@convertion
Feature: Type Conversion (casting)

    Scenario: Convert Number to string
        * def foo = 10
        * def json = {"bar": #(foo+'')}
        * match json == {"bar": "10"}

    Scenario: Convert String tu number
        * def foo = "10"
        # * def json = {"bar": #(foo*1)}
        * def json = {"bar": #(parseInt(foo))}
        * match json == {"bar": 10}

        * def foo = '10'
        * string json = { bar: '#(~~foo)' }
        * match json == '{"bar":10}'

        # JS math puede introducir un punto decimal en algunos casos
        * def foo = 100
        * string json = { bar: '#(foo * 0.1)' }
        * match json == '{"bar":10.0}'

        # pero puede forzar fácilmente a un número entero si es necesario
        * string json = { bar: '#(~~(foo * 0.1))' }
        * match json == '{"bar":10}'

    Scenario: Convert decimal to integer
        * def decimalNumber = 10.5
        * def integerNumber = ~~decimalNumber
        * match integerNumber == 10
