#!/usr/bin/env ruby

module Iptables
  class Firewall
    def status
      `iptables -nvL | sed "s/\s*//g" | egrep ^[0-9] | wc -l`.to_i
    end
    
    def add(options)
      cmd = "iptables -A OUTPUT -p tcp"
      cmd = cmd+" --dport #{options[:port]}" if options[:port]
      cmd = cmd+" -d #{options[:host]}" if options[:host]
      cmd = cmd+" -j DROP"
      puts cmd
      #system(cmd)
    end
    
    def flush
      cmd = "iptables -F"
      system(cmd)
    end
  end
end
