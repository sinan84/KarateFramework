Feature: API test

  Background:
    * url 'https://fakerestapi.azurewebsites.net'
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'

  Scenario:
    Given path "/api/v1/Users/1"
    When method GET
    Then status 200
    And print response
    * def expectedSchema = read ('classpath:data/author.json')
    And print expectedSchema
    And match response == expectedSchema

