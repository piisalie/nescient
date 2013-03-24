module Nescient
  class Bot
    attr_reader :history

    def initialize(address, port)
      @irc     = Connection.new(address, port)
      @history = [ ]
    end

    def listen
      @irc.each do |line|
        @history << Message.new(line)
      end
    end
  end
end
