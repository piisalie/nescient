module Nescient
  class Bot
    def initialize(address, port)
      @irc        = Connection.new(address, port)
      @listen_for = nil
    end

    attr_writer :listen_for

    def run
      fail "bot needs to know what to listen for" unless @listen_for

      @irc.each do |line|
        message = Message.new(line)
        puts message.params.last
        if @listen_for.handle?(message)
          @listen_for.process(message, @irc)
        else
          next
        end
      end
    end
  end
end
