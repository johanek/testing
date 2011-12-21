#!/usr/bin/env rspec

require 'rubygems'
require '../iptables/iptables'
require 'test/unit/assertions'
require 'socket'
require 'etc'
require 'net/ssh'
include Iptables
include Test::Unit::Assertions

When /^I block all traffic to (.*)$/ do |x|
	a = Firewall.new
	b = a.status
	a.add(:host => x) 
	c = a.status
	c.should > b
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

When /^I block all traffic on port (\d+)$/ do |x|
	a = Firewall.new
	b = a.status
	a.add(:port => x, :proto => "tcp")
	a.add(:port => x, :proto => "udp")
	c = a.status
	c.should > b
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

Then /^I want to be able to login with the following credentials$/ do |table|
  table.hashes.each do |hash|
    Net::SSH.start('localhost', hash[:username], :password => hash[:password], :auth_methods => "Password", :timeout => 2)
  end
end
