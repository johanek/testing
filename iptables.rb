#!/usr/bin/env ruby

module Iptables
  class Firewall
    def status
      `iptables -nvL | sed "s/\s*//g" | egrep ^[0-9] | wc -l`.to_i
    end
    
    def add(options = {})
      cmd = "iptables -A OUTPUT -p tcp"
      cmd = cmd+" --dport options[:port]" if options[:port]
      cmd = cmd+" - options[:host]" if options[:host]
      cmd = cmd+" -f DROP"
      puts cmd
    end
    
    def flush
    end
  end
end
