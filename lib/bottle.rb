#!/usr/bin/env ruby

# Bottle - Bot-that-looks-everywhere
# Written by Tate Galbraith
# June 2017

require 'ipaddress'
require 'socket'
require 'colorize'

def check_socket(host, port)
  @socket = Socket.new(:INET, :STREAM)
  @raw_socket = Socket.sockaddr_in(port, host)
  return true if @socket.connect(@raw_socket)
#rescue (Errno::ECONNREFUSED)
#rescue (Errno::ETIMEDOUT)
end

def slash_eights
  # Loop through all class A, B and C address space
  # Append /8 CIDR to string
  # Breaking up all addresses into manageable /8 chunks
  # Instantiate the /8 using IPAddress and loop over all valid addresses in subnet
  for i in 1..223 do
    @subnet_string =  "#{i}.0.0.0/8"
    @subnet_instance = IPAddress(@subnet_string)
    @subnet_instance.each do |v|
      puts "Testing #{v}..."
      if check_socket(v.to_s, 22)
        puts "OPEN".green
      else
        puts "CLOSED".red
      end
    end
  end
end

slash_eights
