Feature: API test

  Background:
    * def baseUrl = 'https://fakerestapi.azurewebsites.net';
    * header Content-Type = 'application/json; charset=utf-8; v=1.0';
    * header Accept = 'application/json'

#    {
#    "id": 1,
#    "idBook": 1,
#    "firstName": "First Name 1",
#    "lastName": "Last Name 1"
#}

  Scenario: Post - Get and PUT Author
#    POST
    Given url baseUrl
    And path '/api/v1/Authors'
    And request
    """
    {
      "id": 23,
      "idBook": 123,
      "firstName": "Kerem",
      "lastName": "Deniz"
    }
    """
    When method POST
    Then status 200
    Then match response == "#object"
    Then match response.firstName == 'Kerem'
    And print response.idBook

    * def authorId = response.id
    * def authorIdBook = response.idBook

#    GET
    Given url baseUrl
    And path '/api/v1/Authors/' + authorId
    When method GET
    Then status 200
    And print response

#    PUT - UPDATE
    Given url baseUrl
    And path '/api/v1/Authors/', authorId
    And request
    """
    {
      "id": 10,
      "idBook": 10,
      "firstName": "EM",
      "lastName": "BU"
    }
    """
    When method PUT
    Then status 200
    Then match response.firstName == 'EM'
    Then match response.lastName == 'BU'
    Then print response

#    DELETE
    Given url baseUrl
    And path '/api/v1/Authors/' + authorId
    When method DELETE
    Then status 200

  Scenario: Post and PUT Author
    Given url baseUrl
    And path '/api/v1/Authors'
    And request
    """
    {
      "id": 10,
      "idBook": 10,
      "firstName": newUser,
      "lastName": "BU"
    }
    """
    When method POST
    Then status 200
    And print response
    And print response.id
    * def idNum = response.id
#    UPDATE
    Given url baseUrl
#    How to put idNum to the below path?
    And path '/api/v1/Authors', idNum
    * def jData = Java.type('utilities.DataGenerator')
    * def newUser = jData.createName()
#    How to put newUser to the firstName of request?
    And request
    """
    {
      "id": 30,
      "idBook": 30,
      "firstName": "Eylul",
      "lastName": "Kasim"
    }
    """
    And method PUT
    And status 200
    And print response
