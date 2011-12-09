Feature: AD Authentication
        Users should be able to login using AD credentials
	If AD fails, we should still be able to login
	If we can't login as an AD user, then we can fallback to a local account


Scenario: should be able to match entries in AD
        Given I am logged in as a user
        Then I want to lookup "vandej01_sys" in the user table
        And I want to lookup "build" in the group table

Scenario: AD unavailable
	When I block all traffic on port 389
        Then I want to lookup "vandej01_sys" in the user table
        And I want to lookup "build" in the group table
	And I want to be able to login with the following credentials
	| username | password |
	| emergencyuser | emergency |
	| root | root |
	And I should flush iptables after

Scenario: Single DC unavailble
	When I block all traffic to rbmdom1011.redbeemedia.net
        Then I want to lookup "vandej01_sys" in the user table
        And I want to lookup "build" in the group table
	And I want to be able to login with the following credentials
	| username | password |
	| emergencyuser | emergency |
	| root | root |
	And I should flush iptables after

Scenario: Teardown
	Then I should flush iptables after
