Feature: API test

  Background:
    * def baseUrl = 'https://fakerestapi.azurewebsites.net';
    * header Accept = 'application/json'

#  GET method application
#  Body:
#  {
#  "id": 10,
#  "title": "Activity 10",
#  "dueDate": "2021-01-03T00:12:32.2271229+00:00",
#  "completed": true
#  }

  Scenario: Get Method and Verify Header
    Given url baseUrl
    And path 'api/v1/Activities/10'
    When method get
    Then status 200
    And match header Content-Type == 'application/json; charset=utf-8; v=1.0'
    And match header Date == '#present'
    And print response
    And print response.title
    And match response.id == 10
    And match response.title == 'Activity 10'
    And match response.completed == true


#    {
#  "id": 10,
#  "userName": "User 10",
#  "password": "Password10"
#}

    Scenario: Assert Json Body
      Given url baseUrl
      And path '/api/v1/Users/10'
      When method get
      Then status 200
      And match header Date == "#present"
      And print response
      And match response.userName == "User 10"
#    directly assert Json body
    And match response == {"id" : 10, "userName": "User 10", "password": "Password10"}
#  assert Json body after creating variable
    * def expectedBody =
    """
    {
      "id": 10,
      "userName": "User 10",
      "password": "Password10"
    }
    """
    And match response == expectedBody