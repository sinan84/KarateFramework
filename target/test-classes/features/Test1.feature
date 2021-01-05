Feature: Updating bookings
  @test6
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