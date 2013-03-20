module Nescient
  class Feed

    attr_reader :history

    def initialize(address, port)
      @irc     = Connection.new(address, port)
      @stream  = @irc.socket
      @history = [ ]
    end

    def listen
      @stream.each do |line|
        @history << Message.new(line)
      end
    end

    def stop
      @stream.close
    end

  end
end
