Feature: AD Authentication
	Users should be able to login using AD credentials
	If AD fails, we should still be able to login with a local account

Scenario: should be able to match entries in AD
	Given I am logged in as a user
	Then I want to lookup "vandej01_sys" in the user table
	And I want to lookup "build" in the group table
	
Scenario: AD unavailable
  Given no firewall rules are set
	When I block all traffic on port 389
	And I block all traffic on port 88
	And I block all traffic on port 749
	Then I want to be able to login with the following credentials
	| username | password |
	| emergencyuser | emergency |
	| root | root |
	And I should flush iptables after

Scenario: All but one DC unavailable
  Given no firewall rules are set
	When I block all traffic to 10.215.4.14
	And I block all traffic to 10.209.205.41
	And I block all traffic to 10.210.205.40
	And I block all traffic to 10.210.205.41
	And I block all traffic to 10.214.1.2
	And I block all traffic to 10.214.1.3
  Then I want to lookup "vandej01_sys" in the user table
	And I want to lookup "build" in the group table
	And I want to be able to login with the following credentials
	| username | password |
	| emergencyuser | emergency |
	| root | root |
	And I should flush iptables after

Scenario: Teardown
	Then I should flush iptables after
