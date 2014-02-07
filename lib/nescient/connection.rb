require 'socket'
require 'openssl'

module Nescient
  class Connection
    def initialize(address, port, ssl)
      if ssl
        p "connecting to #{address}:#{port} SSL"
        build_ssl_socket(address, port)
      else
        p "connecting to #{address}:#{port}"
        @socket = TCPSocket.new(address,port)
      end
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

    private

    def build_ssl_socket(address, port)
      sock = TCPSocket.new(address, port)
      ctx = OpenSSL::SSL::SSLContext.new
      ctx.set_params(verify_mode: OpenSSL::SSL::VERIFY_PEER)

      @socket = OpenSSL::SSL::SSLSocket.new(sock, ctx).tap do |socket|
        socket.sync_close = true
        socket.connect
      end
    end
  end
end
