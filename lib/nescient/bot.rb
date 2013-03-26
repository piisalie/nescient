module Nescient
  class Bot
    def initialize(address, port)
      @irc        = Connection.new(address, port)
      @listen_for = nil
    end

    attr_writer :listen_for

    def run
      fail "Bot needs to know what to listen for" unless @listen_for
      @irc.each do |line|
        message = Message.new(line)
        puts message.trailing
        break if check(message) == :break
        next
      end
    end
    
    def check(message)
      if @listen_for.handle?(message) == :exclusive
        puts "exclusive"
        @listen_for.process(message, @irc)
        return :break
      elsif @listen_for.handle?(message)
        puts "passthrough"
        @listen_for.process(message, @irc)
      else
        puts "skipped"
      end
    end

  end
end
