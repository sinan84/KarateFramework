Feature: API test

  Background:
    * def baseUrl = 'https://gorest.co.in';
    * header Content-Type = 'application/json';
    * header Authorization = 'Bearer 1e2943a10aaff82a9f04e8a3f9fcab3d6e13560d177f59f843b7a91ef51b47f0'

  Scenario: Create User
    Given url baseUrl
#    we can define path if URL is defined directly without "Given url baseUrl"
    And path '/public-api/users'
#    And request { "name":"Erdem Deniz", "gender":"Male", "email":"erdem@gmail.com", "status":"Active"}
#   or
    And request
    """
    {
      "name":"Mehtap Gok",
      "gender":"Female",
      "email":"mehtapgok@gmail.com",
      "status":"Active"
    }
    """
    When method POST
    Then status 200
    And print response

#    *******************************

    Scenario: Create User by Integrate Java Method
      * def jData = Java.type('utilities.DataGenerator')
      * def newUser = jData.createUser()
      * print newUser
      Given url baseUrl
      And path '/public-api/users'
      And request newUser
      And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json'
      When method POST
      Then status 200
      And print response
#     Update name
      * def nameUpdate = response.name
      * def jData = Java.type('utilities.DataGenerator')
      * def newName = jData.createName()
      * def nameUpdate = newName
      * def idNo = response.data.id
      * def codeNo = response.data.code
      And print nameUpdate
      Given url baseUrl
      And path '/public-api/users', idNo
      And print idNo
      And request {"name" : nameUpdate}
      When method PATCH
      Then status 200
      And print response.data.name

#      *********************************
#    Update name

  Scenario: Update Body by PUT
    Given url baseUrl
    And path '/public-api/users/123'
    And header Content-Type = 'application/json; charset=utf-8'
    And header Accept = 'application/json'
    When method GET
    Then status 200
    And print response
#    UPDATE
    * def idNo = response.data.id
    And print idNo
    Given url baseUrl
    And path '/public-api/users', idNo
    And request
    """
    {
        "name":"Meh Gok",
        "gender":"Male",
        "email":"meh@gmail.com",
        "status":"Active"
    }
    """
    And method PUT
    Then status 200
