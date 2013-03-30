module Nescient
  class Bot
    def initialize(connection)
      @irc     = connection
      @actions = [ ]
    end

    def listen_for(action)
      action.connection = @irc
      @actions << action
    end

    def listen
      fail "Bot needs to know what to listen for" if @actions.empty?

      @irc.each do |line|
        message = Message.new(line)
        @actions.each do |action|
          if (wants_it = action.handle?(message))
            action.process(message)
            break if wants_it == :exclusive
          end
        end
      end
    end
  end
end
