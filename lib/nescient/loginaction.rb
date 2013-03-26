module Nescient
  class LoginAction
    ACTIONS = [:nick, :wait, :user, :wait, :join]
    def initialize
      @state = ACTIONS.first
    end

    def handle?(message)
      return :passthrough if message.command.downcase == "notice" &&
        message.params.last.downcase.include?("looking up your hostname")
    end

    def process(message, connection)
      puts "procesed"
    end
    
    def next
      i      = ACTIONS.index(@state)
      @state = ACTIONS[i+1] || :done
    end

  end
end
