#!/usr/bin/env rspec

require '../iptables/iptables'
require 'test/unit/assertions'
require 'socket'
include Iptables
include Test::Unit::Assertions

When /^I block all traffic to (.*)$/ do |x|
	a = Firewall.new
	a.add(:host => x) 
end

Then /^ping (.*) should fail$/ do |x|
	cmd = "ping -w 2 -c 1 #{x} >& /dev/null" 
	s = system(cmd)
	s.should be_false
end

Then /^I should flush iptables after$/ do
	a = Firewall.new
	a.flush
end

When /^I block traffic to port (\d+)$/ do |x|
	a = Firewall.new
	a.add(:port => x)
end

Then /^ssh (.*) should fail$/ do |x|
	cmd = "ssh -p 2222 #{x} -o ConnectTimeout=2 -o PreferredAuthentications=PubKeyAuthentication &> /dev/null"
	s = system(cmd)
	s.should be_false
end


