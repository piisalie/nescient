require 'socket'

module Nescient
  class Connection
    def initialize(address, port)
      @socket = TCPSocket.new(address, port)
    end

    def each(&block)
      @socket.each(&block)
    end

    def puts(*args)
      @socket.puts(*args)
    end

    def close
      @socket.close
    end
  end
end
