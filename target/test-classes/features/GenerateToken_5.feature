Feature: API test

  Background:
#    we can write directly URL
    * url 'https://restful-booker.herokuapp.com'
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'

    @tag3
    Scenario: Generate a Token
      Given path '/auth'
      And request
      """
        {
        "username" : "admin",
        "password" : "password123"
        }
      """
      When method POST
      Then status 200
      And print response
      * def door = response.token
      * print door
#      Go to Target -> surefire-reports -> open .html on browser to get report

  Scenario:
