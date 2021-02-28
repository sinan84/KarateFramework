Feature: Call data from different feature

  @tag10
  Scenario: Variables
    * def age1 = 40
    * def age2 = 20
    * def total1 = age1 + age2
    * print total1

    @tag9
  Scenario: From different feature
      * print 'This is from same @tag9'
      * def tag10 = call read('CallFeatureData13.feature@tag10')
#      We can only call different scenario, not to use its call in the current scenario
#      * def ttl = tag10 + 10
#      * print ttl
      * def var1 = tag10.age1
      * print var1
      * def t = var1 + 10
      * print t

  @tag8
  Scenario: Call one scenario from another one2
    * print 'This is from same scenario'
    * def cFeature = call read('CallFeatureData13.feature@tag9')
#       We can only call different scenario, not to use its call in the current scenario
    * def ttl = cFeature.t
    * print ttl

  Scenario: Call one scenario from another one
    * print 'This is from same scenario'
    * def cFeature = call read('Fundamental-1.feature@tag1')
#       We can only call different scenario, not to use its call in the current scenario
    * def ttl = 5 + cFeature.age
    * print ttl