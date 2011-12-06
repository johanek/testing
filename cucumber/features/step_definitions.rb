#!/usr/bin/env rspec

require '../iptables/iptables'
require 'test/unit/assertions'
require 'socket'
require 'etc'
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

Given /^I am logged in as a user$/ do
  user = ENV['USER']
  user.is_a?(String)
end

Then /^I want to lookup "([^"]*)" in the user table$/ do |arg1|
  Etc.getpwnam(arg1)
end

Then /^I want to lookup "([^"]*)" in the group table$/ do |arg1|
  Etc.getgrnam(arg1)
end
