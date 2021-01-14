Feature: Call data from different feature

  @tag10
  Scenario: Variables
    * def age1 = 40
    * def age2 = 20
    * def total = age1 + age2
    * print total

  Scenario: From different feature
      * print 'This is from same feature'
      * def cFeature = call read('KarateFundamental_1.feature@tag5')
      * print cFeature

  Scenario: From same feature
    * print 'This is from same feature'
    * def cFeature = call read('CallFeatureData13.feature@tag10')
    * def moveD = cFeature
    * def total = 5 + moveD
    * print cFeature.total