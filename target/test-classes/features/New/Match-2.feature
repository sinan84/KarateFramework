Feature: Match application

  Scenario: Match
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
    * match employee.lastName == '#present

  Scenario: Match each
    * def data = { sample: [{ bar: 1, baz: 'a' }, { bar: 2, baz: 'b' }, { bar: 3, baz: 'c' }]}
    * match each data.sample == { bar: '#number', baz: '#string' }