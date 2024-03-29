#!/usr/bin/env ruby

module Iptables
  class Firewall
  
    def status
      `iptables -nvL | sed "s/\s*//g" | egrep ^[0-9] | wc -l`.to_i
    end
    
    def add(options)
	  options = {:proto => 'tcp'}.merge(options)
      cmd = "iptables -A OUTPUT"
      cmd = cmd+" -p #{options[:proto]} --dport #{options[:port]}" if options[:port]
      cmd = cmd+" -d #{options[:host]}" if options[:host]
      cmd = cmd+" -j DROP"
      system(cmd)
    end
    
    def flush
      cmd = "iptables -F"
      system(cmd)
    end
  end
end
