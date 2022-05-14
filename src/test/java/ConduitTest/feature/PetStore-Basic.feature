@petStoreBasic
Feature: Tienda de mascotas

    CRUD de mi tienda de mascotas

    Scenario: Añadir una mascota a la tienda
        Given url "https://petstore.swagger.io/v2/pet"
        * def newPet = read('classpath:ConduitTest/json/newPet.json')
        * def id_newPet = function(){ return Math.floor(Math.random() * 50000) }
        # * set newPet.id = id_newPet() es similar a call id_newPet
        * set newPet.id = call id_newPet
        And request newPet
        When method Post
        Then status 200
        And match response ==
            """
            {
                "id": "#number",
                "category": {
                    "id": "#number",
                    "name": "#string"
                },
                "name": "#string",
                "photoUrls": [
                    "#string"
                ],
                "tags": [
                    {
                        "id": "#number",
                        "name": "#string"
                    }
                ],
                "status": "#string"
            }
            """
        And match response == newPet

    Scenario: Consultar la mascota ingresada previamente (Búsqueda por ID)
        Given url "https://petstore.swagger.io/v2/pet"
        * def newPet = read('classpath:ConduitTest/json/newPet.json')
        * def id_newPet = function(){ return Math.floor(Math.random() * 50000) }
        * set newPet.id = call id_newPet
        Given request newPet
        When method Post
        Then status 200

        Given url "https://petstore.swagger.io/v2/pet/" + newPet.id
        When method Get
        Then status 200
        And match response == newPet

    Scenario: Actualizar el nombre de la mascota y el estatus de la mascota a "sold"
        Given url "https://petstore.swagger.io/v2/pet"
        * def newPet = read('classpath:ConduitTest/json/newPet.json')
        * def id_newPet = function(){ return Math.floor(Math.random() * 50000) }
        * set newPet.id = call id_newPet
        Given request newPet
        When method Post
        Then status 200

        * def updatePet = newPet
        * set updatePet.name = "Skoty BP"
        * set updatePet.status = "sold"
        Given request updatePet
        When method Put
        Then status 200
        And match response == updatePet

    Scenario: Consultar la mascota modificada por estado (Búsqueda por estatus)
        Given url "https://petstore.swagger.io/v2/pet"
        * def newPet = read('classpath:ConduitTest/json/newPet.json')
        * def id_newPet = function(){ return Math.floor(Math.random() * 50000) }
        * set newPet.id = call id_newPet
        Given request newPet
        When method Post
        Then status 200

        * def updatePet = newPet
        * set updatePet.name = "Skoty BP"
        * set updatePet.status = "sold"
        Given request updatePet
        When method Put
        Then status 200

        Given path 'findByStatus'
        Given param status = 'sold'
        When method Get
        Then status 200
        And match response contains updatePet