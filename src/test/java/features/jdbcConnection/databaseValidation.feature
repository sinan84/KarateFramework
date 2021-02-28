# We need to add dependency for jdbc connection to mariaDB and spring JDBC;
#      <dependency>
#          <groupId>org.mariadb.jdbc</groupId>
#          <artifactId>mariadb-java-client</artifactId>
#          <version>2.7.1</version>
#      </dependency>

#      <dependency>
#           <groupId>org.springframework</groupId>
#           <artifactId>spring-jdbc</artifactId>
#           <version>5.3.4</version>
#       </dependency>

Feature: JDBC connection and Database validation

#   for jdbc connection;
#   https://github.com/intuit/karate/blob/master/karate-demo/src/test/java/demo/dogs/dogs.feature

  Background:
    * def config = { username: 'finspire_user', password: 'beniYakmaKendini357YakHerseyiYak!!!!', url: 'jdbc:mariadb://maria.test.finspire.tech:3306/security-manager?createDatabaseIfNotExist=true', driverClassName: 'org.mariadb.jdbc.Driver' }
    * def DbUtils = Java.type('features.jdbcConnection.DbUtils')
    * def db = new DbUtils(config)
#    * header Authorization = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjdXJyZW5jeU5hbWUiOiJQb3VuZCIsImN1cnJlbmN5IjoiR0JQIiwic3ltYm9sIjoiwqMiLCJlZmZlY3RpdmVEYXRlIjoiMjAyMS0wMS0yMCJ9.nKmlyMyELZbW6QWJjVZAN0aV_XfjKy3xPLC8yK7Rsz8'

  Scenario: Data valitation
    * def verCode = db.readRows("Select * from `security-manager`.`user` u where verification_code = '861024'")
    * print verCode
    * def vc1 = verCode[0].verification_code
    * print vc1
#    * def vc = verCode.verification_code
#    * print vc

  Scenario: Insert rows
    * def write = db.insertRows('INSERT INTO `loan-account-manager`.currency c (currencyName, currency, symbol, effectiveDate) values ("Pound", "GBP", "£", "2021-03-20")')
    * def currency = db.Rows("SELECT * from `loan-account-manager`.currency c")
    * print currency

