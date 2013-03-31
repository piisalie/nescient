module Nescient
  class LoginAction < Action
    STEPS = [:login, :awaiting_welcome, :awaiting_join, :done]

    def initialize(bot_name)
      super()
      @bot_name = bot_name
      @step     = STEPS.first
    end

    def handle?(message)
      if @step == :login
        :exclusive
      elsif @step == :awaiting_welcome and message.command == "001"
        :exclusive
      elsif @step == :awaiting_welcome and message.command == "433"
        :exclusive
      elsif @step                == :awaiting_join and
            message.command      == "JOIN"         and
            message.params.first == "#bottest"
        :exclusive
      else
        false
      end
    end

    def process(message)
      case @step
      when :login
        send_login(@connection)
      when :awaiting_welcome
        case message.command
        when "001"
          send_join(@connection)
        when "433"
          send_alternative_nick(@connection)
        end
      when :awaiting_join
        advance
      end
    end

    def advance
      i     = STEPS.index(@step)
      @step = STEPS[i + 1]
    end

    def send_login(connection)
      connection.puts "USER #{@bot_name}Bot 0 * :Nessy Tut"
      connection.puts "NICK :#{@bot_name}"
      advance
    end

    def send_alternative_nick(connection)
      connection.puts "NICK :#{@bot_name}_"
    end

    def send_join(connection)
      connection.puts "JOIN :#bottest"
      advance
    end
  end
end
