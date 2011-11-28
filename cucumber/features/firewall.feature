Feature: Firewall
	In order to create build tests
	As an agile sysadmin
	I want to recreate service and network failures

	Scenario: Block johan.org.uk
		When I block all traffic to johan.org.uk
		Then ping johan.org.uk should fail
		And I should flush iptables after

	Scenario: Block SSH traffic
		When I block traffic to port 2222
		Then ssh johan.org.uk should fail
		And I should flush iptables after
