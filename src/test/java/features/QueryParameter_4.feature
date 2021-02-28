Feature: API test

  Background:
#    we can directly define URL
    * url 'https://gorest.co.in'
    * header Authorization = 'Bearer 1e2943a10aaff82a9f04e8a3f9fcab3d6e13560d177f59f843b7a91ef51b47f0'

  Scenario: Query parameter
#    we can define path if URL is defined directly
    Given path '/public-api/users'
    And param page = 1
    When method GET
    Then status 200
    And match header Content-Type == 'application/json; charset=utf-8'
    And print response
#    After each running, the below match might be updated
    And match response.data[*].name contains 'Vedanga Mehrotra'
    And match response.data[*].email contains 'prem_ii_naik@lynch.org'
    And match response.data[*].gender contains 'Male'
    And match response.data[0].name == 'Vedanga Mehrotra'
    And match each response.data[*].id == '#number'

#    {
#    "code": 200,
#    "meta": {
#        "pagination": {
#            "total": 1,
#            "pages": 1,
#            "page": 1,
#            "limit": 20
#        }
#    },
#    "data": [
#        {
#            "id": 16,
#            "name": "Arya Dubashi",
#            "email": "dubashi_arya@johns.biz",
#            "gender": "Male",
#            "status": "Active",
#            "created_at": "2021-01-02T03:50:03.779+05:30",
#            "updated_at": "2021-01-02T03:50:03.779+05:30"
#        }
#    ]
#}

  Scenario: More than one Query parameter
    Given path '/public-api/users'
#    After each running, the below match might be updated
#    And param name = 'Arya Dubashi'
#    And param id = 16
#    or
    * params {name : 'Arya Dubashi', id : 16}
    When method GET
    Then status 200
    And match header Content-Type == 'application/json; charset=utf-8'
    And print response
#    After each running, the below match might be updated
    And match response.data[*].name contains 'Arya'
    And match response.data[*].email contains 'dubashi_arya@johns.biz'
    And match response.data[*].gender contains 'Male'