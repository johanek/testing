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
      a.add(:host => "johan.org.uk", :port => "2222")
      c = a.status
      c.should > b
    end
  end
  
  describe '.flush' do
    
  end
  
end
