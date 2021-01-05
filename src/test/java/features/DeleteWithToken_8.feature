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


