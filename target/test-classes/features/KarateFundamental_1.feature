Feature: Stripe Create User Feature

  Scenario: Printing
    Given print "Some words"
    * print "My name is", "Karate Kid"
    * print 2+2

  Scenario: Variables
    * def name = 'Emrah'
    * print 'My name is ' + name
    * def age = 20
    * print name, 'is', age, 'years old'

  Scenario: Difficult parameters: json object
    * def student = {'name' : 'Emrah', 'age' : 40}
    * print student
    * print student.name
    * print student.age

  Scenario: Json Object 2
    * def student =
    """
    'firstName' = 'Meltem',
    'lastName' = 'Bulut',
    'age' = 5
    """
    * print student
    * print student.firstName

  Scenario: Array Object
    * def students =
      """
      [
      {
      'name' : 'Erdem',
      'payment' : false
      },
      {
      'name' : 'Ozlem',
      'payment' : true
      }
      ]
      """
    * print students
    * print students[0].name
    * print students[1].payment




