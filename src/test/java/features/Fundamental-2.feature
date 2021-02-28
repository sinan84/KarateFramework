Feature: Fundamental knowledge for Karate framework

  Scenario: Variable definition and print
    * def name = 'Emrah Bulut'
    * def number = 5
    * print name
    * print number

  Scenario: More examples for Match
    * def employee =
    """
    {
      "first_name":"TJ",
      "salary":24001,
      "active":true
    }
    """
    * def emp_name = employee.first_name
    * match employee.first_name == 'TJ'
    * match emp_name == 'TJ'
    * match employee.salary == 24001
    * match employee.salary != 200

  Scenario: Json body assertion
    * def employee =
      """
      {
      "firstName" : 'e',
      "lastName" : 'b',
      "salary" : 15,
      "active" : true
      }
      """
    * match employee.firstName == '#string'
    * match employee.salary == '#number'
    * match employee.active == '#boolean'
    * match employee.lastName == '#present'

  Scenario: fuzzy matching
    * def employee =
  """
    {
      "first_name": "TJ",
      "salary": 24001,
      "active":true
    }
    """
    * match employee.first_name == '#string'
    * match employee.salary == '#number'
    * match employee.active == '#boolean'

  Scenario: !contains
    * def employees =
    """
    [
      {'firstName' : "EB",
        'salary' : 2000,
        'active' : true
      },
      {
      'firstName' : "ST",
      'salary' : 2500,
      active' : false
      }
      ]
    """
    * def l = employees.length
    * print l
    * match l == 2
    * match employees contains any [{"firstName" : "EB", "salary" : 2000, "active" : true}, {"firstName" : "DD", "salary" : 1000, "active" : false}]
#    * match employees !contains {"firstName" : "ST", "salary" : 2000, "active" : false}

  Scenario: match contains only
#    For those cases where you need to assert that all array elements are present but in any order
    * def data = { foo: [1, 2, 3] }
    * match data.foo contains 1
    * match data.foo contains [2]
    * match data.foo contains [3, 2]
    * match data.foo contains only [3, 2, 1]
    * match data.foo contains only [2, 3, 1]
    # * match data.foo contains only [2, 3]

  Scenario: contains matching1
    * def data = { foo: [1, 2, 3] }
    * match data.foo contains any [9, 2, 8]

  Scenario: contains matching2
    * def employees =
  """
  [
     {
      "first_name":"TJ",
      "salary":24001,
      "active":true
     },
     {
      "first_name":"Steven",
      "salary":2100,
      "active":false
     }
    ]
    """
    * def length = employees.length
    * print length
    * match  length == 2
    * match employees contains any {"first_name":"TJ","salary":24001,"active":true }
#    * match employees contains any {"first_name":"TJ","salary":24005,"active":true }

  Scenario: Match each2
    * def data = { foo: [{ bar: 1, baz: 'a' }, { bar: 2, baz: 'b' }, { bar: 3, baz: 'c' }]}
#    * match each data.foo == { bar: '#number', baz: '#string' }
# and you can use 'contains' the way you'd expect
#    * match each data.foo contains { bar: '#number' }
    * match each data.foo contains { bar: '#? _ > 0 && _ < 4'}

  Scenario: Contains ..  ('../LoanAccountManager/Get-AllCurrency.feature@wip')
    Given def cat =
  """
  {
    name: 'Billie',
    kittens: [
      { id: 23, name: 'Bob' },
      { id: 42, name: 'Wild' }
    ]
  }
  """
#  Then match cat.kittens[*].id == [23, 42]
#  Then match cat.kittens[*].id contains 23
#  Then match cat.kittens[*].id contains [42]
#  Then match cat.kittens[*].id contains [23, 42]
#  Then match cat.kittens[*].id contains [42, 23]
    Then match cat..name == ['Billie', 'Bob', 'Wild']
    Then match cat.kittens contains [{ id: 42, name: 'Wild' }, { id: 23, name: 'Bob' }]
    Then match cat.kittens contains { id: 42, name: '#string' }

#  contains deep
  Scenario: recurse nested json
    * def original = { a: 1, b: 2, c: 3, d: { a: 1, b: 2 } }
    * def expected = { a: 1, c: 3, d: { b: 2 } }
    * match original contains deep expected

  Scenario: recurse nested array
    * def original = { a: 1, arr: [ { b: 2, c: 3 }, { b: 3, c: 4 } ] }
    * def expected = { a: 1, arr: [ { b: 2 }, { c: 4 } ] }
    * match original contains deep expected

  Scenario: match each
    Given def json =
      """
      {
        "hotels": [
          { "roomInformation": [{ "roomPrice": 618.4 }], "totalPrice": 618.4  },
          { "roomInformation": [{ "roomPrice": 679.79}], "totalPrice": 679.79 }
        ]
      }
      """
    Then match each json.hotels contains { totalPrice: '#? _ == _$.roomInformation[0].roomPrice' }
# when validation logic is an 'equality' check, an embedded expression works better
    Then match each json.hotels contains { totalPrice: '#(_$.roomInformation[0].roomPrice)' }


  Scenario: contains user details
    * def user =
  """
    {
    "status": "success",
    "data" : {
          "name" : "test",
          "salary" : "123",
          "age" : "23",
          "id" : 73
         }
    }
    """
    * match user contains {"status": "success"}
    * match user.data contains {"salary" : "123"}


