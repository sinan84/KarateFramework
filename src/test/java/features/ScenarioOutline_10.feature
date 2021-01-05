Feature: API test

  Background:
    * url 'https://fakerestapi.azurewebsites.net'
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'

  Scenario Outline:
    Given path "/api/v1/Users"
    And request
    """
    {
      "id": '<id>',
      "userName": '<userName>',
      "password": '<password>'
    }
    """
    When method POST
    Then status 200
    And print response
    Then match response == {"id" : "#number", "userName" : "#string","password" : "#string"}

    Examples:
      | id | userName | password |
      | 13 | edeniz   | 1234     |
      | 25 | demrah   | 2345     |
      | 27 | berdem   | 3456     |
