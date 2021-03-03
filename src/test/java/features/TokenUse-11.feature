Feature: API test

  Background:
    * url 'https://restful-booker.herokuapp.com'
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'

  Scenario:
    Given path "/auth"
    And request
    """
    {
    "username" : "admin",
    "password" : "password123"
    }
    """
    When method POST
    Then status 200
    And print response.token
    * def tokenReceived = response.token
    * print token

#    PUT or DELETE
    Given url "https://restful-booker.herokuapp.com/"
    And path "booking/"
    And path 5
    And header Cookie = 'token=' + tokenReceived
    And request
    """
    {
      "firstname" : "James",
      "lastname" : "Brown",
      "totalprice" : 111,
      "depositpaid" : true,
      "bookingdates" : {
          "checkin" : "2018-01-01",
          "checkout" : "2019-01-01"
      },
      "additionalneeds" : "Breakfast"
    }
    """
    And method PUT
    And status 200
    And print response

  Scenario: The user updates his/her booking
    Given url "https://restful-booker.herokuapp.com/"
    And path "auth"
    And header Content-Type = "application/json"
    And header Accept = "application/json"
    And request
    """
    {
    "username" : "admin",
    "password" : "password123"
    }
    """
    When method POST
    Then status 200
    And print response.token
    And def tokenreceived = response.token
# Update
    Given url "https://restful-booker.herokuapp.com/"
    And path "booking/"
    And path 5
    And header Content-Type = "application/json"
    And header Accept = "application/json"
    And header Cookie = "token=" + tokenreceived
    And def schema =
    """
    {
    "firstname" : "#string",
    "lastname" : "#string",
    "totalprice" : "#number",
    "depositpaid" : "#boolean",
    "bookingdates" : {
        "checkin" : "#string",
        "checkout" : "#string"
    },
    "additionalneeds" : "#string"
    }
    """
    And request
    """
    {
    "firstname" : "James",
    "lastname" : "Brown",
    "totalprice" : 111,
    "depositpaid" : true,
    "bookingdates" : {
        "checkin" : "2018-01-01",
        "checkout" : "2019-01-01"
    },
    "additionalneeds" : "Breakfast"
    }
    """
    When method PUT
    Then status 200
    And print response
    And match response == schema

