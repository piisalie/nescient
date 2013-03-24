require 'socket'

module Nescient
  class Connection
    def initialize(address, port)
      @socket = TCPSocket.new(address, port)
    end

    def each(&block)
      @socket.each(&block)
    end

    def puts(line)
      @socket.puts(line)
    end

    def close
      @socket.close
    end
  end
end
