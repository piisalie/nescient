module Nescient
  class LoginAction
    ACTIONS = [ :user, :nick, :join ]
    def initialize
      @state = ACTIONS.first
    end

    def handle?(message)
      return :passthrough if 
        message.trailing.downcase.include?("checking ident")
      return :exclusive if
        message.trailing.downcase.include?("found your hostname")
    end

    def process(message, connection)
      puts "procesed"
      case @state
      when :done
        puts "we're done here"
      when :user
        send_user(connection)
      when :nick
        send_nick(connection)
      when :join
        puts "do join stuff"
        advance
      else
        puts "there's something wrong"
      end
    end
    
    def advance
      i      = ACTIONS.index(@state)
      @state = ACTIONS[i+1] || :done
    end

    def send_user(connection)
      connection.puts "USER NescientBot 0 * :Nessy Tut"
      puts "user message sent"
      advance
    end

    def send_nick(connection)
      connection.puts "NICK Nescient"
      puts "nick message sent"
      advance
    end
  end
end
