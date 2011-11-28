#!/usr/bin/env ruby

require 'iptables'
include Iptables

describe 'Firewall' do
  
  describe '.status' do
    it "return a number" do
      a = Firewall.new
      num = a.status
      num.is_a.should == "number"
    end
  end
  
  describe '.add' do
    it "create a new rule" do
      num = Iptables.status
      Iptables.add
    end
  end
  
  describe '.flush' do
    
  end
  
end
