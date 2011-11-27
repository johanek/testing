#!/usr/bin/env ruby

require 'iptables'

describe 'Iptables' do
  
  describe '.add' do
    it "create a new rule" do
      num = Iptables.status
      Iptables.add
    end
  end
  
  describe '.flush' do
    
  end
  
end
