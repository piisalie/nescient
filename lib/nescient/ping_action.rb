module Nescient
  class PingAction < Action
    def handle?(message)
      if message.command.downcase == "ping"
        :exclusive
      else
        false
      end
    end

    def process(message)
      host_pong(@connection, message.params)
    end

    def host_pong(connection, params)
      connection.puts "PONG #{params.join(' ')}"
    end
  end
end
