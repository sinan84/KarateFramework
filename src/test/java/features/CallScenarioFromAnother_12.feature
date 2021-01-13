Feature: Call output of one scenario by different scenario

  @tag1
  Scenario: First Scenario
    * print 'This is first scenario'

  Scenario: Second Scenario
    * print 'This is second one"
    * def firstSc = call read ('CallScenarioFromAnother_12.feature@tag1')
    * print firstSc
