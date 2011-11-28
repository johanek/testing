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
    it "create a new rule" do
      a = Firewall.new
      b = a.status
      a.add(:host => "johan.org.uk")
      c = a.status
      c.should > b
      #a.flush
    end
  end
  
  describe '.flush' do
    it "removes all rules" do
      a = Firewall.new
      b = a.status
      a.flush
      c = a.status
      c.should == 0
    end
  end
  
end
