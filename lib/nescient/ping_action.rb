module Nescient
  class PingAction
    def initialize
      @type = :host_ping
    end

    def handle?(message)
      if message.command.downcase == "ping"
        :exclusive
      elsif message.command.downcase == "privmsg" and
            message.params.last.downcase.include?("ping")
        @type = :user_ping
        :exclusive
      else
        false
      end
    end

    def process(message, connection)
      case @type
      when :host_ping
        host_pong(connection)
      when :user_ping
        user_pong(connection, message)
      end
    end

    def host_pong(connection)
      connection.puts "PONG"
    end

    def user_pong(connection, message)
      puts "userpong"
    end

  end
end
