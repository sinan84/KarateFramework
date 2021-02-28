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
      "name":"Meryem",
      "gender":"Female",
      "email":"meryem@gmail.com",
      "status":"Active"
    }
    """
    When method POST
    Then status 200
    And print response
    * match response.data[0].field == "email"

#    *******************************

    Scenario: Create User by Integrate Java Method
      * def newUser = Java.type('utilities.DataGenerator').createUser()

#      * def newUser = jData.createUser()

      * print newUser

      Given url baseUrl
      And path '/public-api/users'

      And request newUser

      And header Content-Type = 'application/json; charset=utf-8'
      And header Accept = 'application/json'

      When method POST
      Then status 200
      And print response
      And print response.data[0].name

#     Update name
      * def oldName = response.name

      * def newName = Java.type('utilities.DataGenerator').createName()

      * print newName
      * def idNo = response.data.id
      * def codeNo = response.data.code

      And print oldName

      Given url baseUrl
      And path '/public-api/users', idNo

      And print idNo

      And request {"name" : newName}

      When method PATCH
      Then status 200
      And print response.data.name
      And match oldName != newName

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
    * def idNo = response.data.code
    And print idNo
    Given url baseUrl
    And path '/public-api/users', code
    And request
    """
    {
      "data": {
        "message": "Resource not found"
      },
      "meta": null
    }
    """
    And method PUT
    Then status 200
