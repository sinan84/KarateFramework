Feature: Contains application

  Scenario: "contains only" with match
#    For those cases where you need to assert that all array elements are present but in any order
    * def data = { code: [1, 2, 3] }
    * match data.code contains 1
    * match data.code contains [2]
    * match data.code contains [3, 2]
    * match data.code contains only [3, 2, 1]
    * match data.code contains only [2, 3, 1]

#    For contains only, we need to define all elements without order; hence, below fails
    # * match data.code contains only [2, 3]

  Scenario: "contains any" with match
    * def data = { numbers: [1, 2, 3] }
    * match data.numbers contains any [9, 2, 8]

  Scenario: Contains any
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
#    match whole ---{"first_name":"TJ","salary":24001,"active":true }-- with each array element
    * match employees contains any {"first_name":"TJ","salary":24001,"active":true }
#    below fails
#    * match employees contains any {"first_name":"TJ","salary":2100,"active":true }
#    * match employees contains any {"first_name":"TJ","salary":24005,"active":true }

  Scenario: Predicate marker "#?"
#    ‘Self’ Validation Expressions
#    The special ‘predicate’ marker #? EXPR in the table above is an interesting one. It is best explained via examples.
#    Any valid JavaScript expression that evaluates to a Truthy or Falsy value is expected after the #?.
#    Observe how the value of the field being validated (or ‘self’) is injected into the ‘underscore’ expression variable: ‘_’

    * def date = { month: 3 }
    * match date == { month: '#? _ > 0 && _ < 13' }
    * def min = 1
    * def max = 12
    * match date == { month: '#? _ >= min && _ <= max' }

  Scenario: Contains with "match each" and predicate marker
    * def data = { sample: [{ bar: 1, baz: 'a' }, { bar: 2, baz: 'b' }, { bar: 3, baz: 'c' }]}
# and you can use 'contains' the way you'd expect
    * match each data.sample contains { bar: '#number' }

    #  The special ‘predicate’ marker #? EXPR
    * match each data.sample contains { bar: '#? _ > 0 && _ < 4'}

  Scenario: "*" with Match and Contains
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
    Then match cat.kittens[*].id == [23, 42]
    Then match cat.kittens[*].id contains 23
    Then match cat.kittens[*].id contains [42]
    Then match cat.kittens[*].id contains [23, 42]
    Then match cat.kittens[*].id contains [42, 23]

  Scenario: ".." in Match and Contains
      # the .. operator is great because it matches nodes at any depth in the JSON "tree"
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
    Then match cat..name == ['Billie', 'Bob', 'Wild']
    Then match cat.kittens contains [{ id: 42, name: 'Wild' }, { id: 23, name: 'Bob' }]
    Then match cat.kittens contains { id: 42, name: '#string' }

#  contains deep
#  This modifies the behavior of match contains so that nested lists or objects are processed
#  for a “deep contains” match instead of a “deep equals” one which is the default.
#  This is convenient for complex nested payloads where you are sure that you only want to
#  check for some values in the various “trees” of data.

  Scenario: recurse nested json
    * def original = { a: 1, b: 2, c: 3, d: { a: 1, b: 2 } }
    * def expected = { a: 1, c: 3, d: { b: 2 } }
    * match original contains deep expected

  Scenario: recurse nested array
    * def original = { a: 1, arr: [ { b: 2, c: 3 }, { b: 3, c: 4 } ] }
    * def expected = { a: 1, arr: [ { b: 2 }, { c: 4 } ] }
    * match original contains deep expected

  Scenario: Match each for same payload
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


     #  Contains ..  ('../LoanAccountManager/Get-AllCurrency.feature@wip')




