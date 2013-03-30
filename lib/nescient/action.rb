module Nescient
  class Action
    def initialize
      @connection = nil
    end

    attr_writer :connection

    def send_command(command, *params)
      args = [command]
      args.push(*params[0..-2])
      args << ":#{params.last}" if params.last
      @connection.puts args.join(" ") + "\r\n"
    end

    def send_message(to, message)
      send_command("PRIVMSG", to, message)
    end

    def send_reply(replying_to, message)
      send_message(replying_to.params.first, message)
    end
  end
end
