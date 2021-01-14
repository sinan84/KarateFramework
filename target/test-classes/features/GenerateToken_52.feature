Feature: Generate token inside one feature and call it by different feature

  Background:
    * url 'https://restful-booker.herokuapp.com'

    * def generateToken = call read('GenerateToken_5.feature')

#    or

#    * def generateToken = call read('GenerateToken_51.feature'){username : 'admin', password : 'password123'}

    * def accessToken = generateToken.token
    * print accessToken

  Scenario:
    And path "booking/"
    And path 5
    And header Content-Type = "application/json"
    And header Accept = "application/json"
    And header Cookie = "token=" + accessToken
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