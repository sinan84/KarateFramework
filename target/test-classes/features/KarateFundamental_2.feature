Feature: Assertion by using match word

  Scenario: Examples for match
    * def name = 'Emrah Bulut'
    * match name == 'Emrah Bulut'
    * match name != 'Emrah Bult'

  Scenario: more matching example
    * def employee =
    """
    {
      "first_name":"TJ",
      "salary":24001,
      "active":true
    }
    """
    * def emp_name = employee.first_name
    * match emp_name == 'TJ'
    * match employee.salary == 24001

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
      "first_name":"TJ",
      "salary":24001,
      "active":true
    }
    """
    * match employee.first_name == '#string'
    * match employee.salary == '#number'
    * match employee.active == '#boolean'
    * match employee.last_name == '#notpresent'

  Scenario: Match "contains"
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
    * def length = employees.length
    * print length
    * match length == 2
    * match employees contains any {"firstName" : "EB", "salary" : 2000, "active" : true}
    * match employees !contains {"firstName" : "ST", "salary" : 2000, "active" : true}

  Scenario: contains matching
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

  Scenario: Match "each"
    * def data = { foo: [{ bar: 1, baz: 'a' }, { bar: 2, baz: 'b' }, { bar: 3, baz: 'c' }]}
    * match each data.foo == { bar: '#number', baz: '#string' }
    * match each data.foo contains { bar: '#number' }
    * match each data.foo contains { bar: '#? _ != 4' }







