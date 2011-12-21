#!/usr/bin/env ruby

require 'iptables'
include Iptables

describe 'Firewall' do
  
  describe '.status' do
    it "return a number" do
      a = Firewall.new
      num = a.status
      num.class.should == Fixnum
    end
  end
  
  describe '.add' do
    it "create a new host rule" do
      a = Firewall.new
      b = a.status
      a.add(:host => "google.com")
      c = a.status
      c.should > b
      a.flush
    end
	
    it "create a new port rule with protocol" do
      a = Firewall.new
      b = a.status
      a.add(:port => "389", :proto => "tcp")
      c = a.status
      c.should > b
      a.flush
    end
  end

  describe '.flush' do
    it "removes all rules" do
      a = Firewall.new
      a.flush
      b = a.status
      b.should == 0
    end
  end
  
end
