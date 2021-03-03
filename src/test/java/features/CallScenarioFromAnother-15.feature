Feature: Call output of one scenario by different scenario

#  @tag1
#  Scenario: First Scenario
#    * def num1 = 5
#    * print num1 + 7
#
#  Scenario: Second Scenario
#    * def num2 = 3
#    * def num3 = call read('CallFeatureData13.feature@tag1')
#    * print num3
#    * print num2 + num3

  @tag3
  Scenario: First Scenario
    * print 'This is from different feature'

  Scenario: Second Scenario
    * print 'This is second one'
    * def firstSc = call read('CallScenarioFromAnother_12.feature@tag3')