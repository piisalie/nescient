module Nescient
  class LoginAction
    STEPS = [:login, :awaiting_welcome, :join, :awaiting_join, :done]

    def initialize
      @step = STEPS.first
    end

    def handle?(message)
      if @step == :login
        :exclusive
      elsif @step == :awaiting_welcome and message.command == "001"
        advance
        :exclusive
      elsif @step                == :awaiting_join and
            message.command      == "JOIN"         and
            message.params.first == "#bottest"
        advance
        false
      else
        false
      end
    end

    def process(message, connection)
      case @step
      when :login
        send_login(connection)
      when :join
        send_join(connection)
      end
    end

    def advance
      i     = STEPS.index(@step)
      @step = STEPS[i + 1]
    end

    def send_login(connection)
      connection.puts "USER NescientBot 0 * :Nessy Tut"
      connection.puts "NICK :Nescient"
      advance
    end

    def send_join(connection)
      connection.puts "JOIN :#bottest"
      advance
    end
  end
end
