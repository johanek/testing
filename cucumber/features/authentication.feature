Feature: AD Authentication
        Users should be able to login using AD credentials

Scenario: should be able to match entries in AD
        Given I am logged in as a user
        Then I want to lookup "vandej01" in the user table
        And I want to lookup "build" in the group table