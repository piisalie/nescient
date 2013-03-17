require 'socket'

module Nescient
  class Connection

    attr_reader :socket

    def initialize(address, port)
      @address, @port = address, port
      @socket = TCPSocket.new(@address, @port)
    end
  end
end
