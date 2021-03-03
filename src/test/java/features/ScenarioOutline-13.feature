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
    * def faker = Java.type('com.finspire.utilities.DataGenerator')
    * def createID = faker.createId

#    * def faker = read('../utilities/DataGenerator.js')
#    * def createID = read('../utilities/DataGenerator/createId()')
#  read('../callarray/kittens.json')
#    * def someValue = read('some-js-code.js')

    When method POST
    Then status 200
    And print response
    Then match response == {"id" : "#number", "userName" : "#string","password" : "#string"}

    Examples:
      | id       | userName | password |
      | createID | edeniz   | 1234     |
      | 25       | demrah   | 2345     |
      | 27       | berdem   | 3456     |

