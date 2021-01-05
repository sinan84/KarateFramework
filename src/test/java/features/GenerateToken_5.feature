Feature: API test

  Background:
#    we can write directly URL
    * url 'https://restful-booker.herokuapp.com'
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'

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
      * def token = response.token
#      Go to Target -> surefire-reports -> open .html on browser to get report