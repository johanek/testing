#!/usr/bin/env ruby

module Iptables
  class Firewall
    def status
      `iptables -nvL | sed "s/\s*//g" | egrep ^[0-9] | wc -l`
    end
    def add
    end
    def flush
    end
  end
end
