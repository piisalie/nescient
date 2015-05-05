module Nescient
  class SquareAction < Action
    def handle?(message)
      if message.command == "PRIVMSG" and
          message.params.last.include?("!square")
        :exclusve
      else
        false
      end
    end

    def process(message)
      send_reply(message, "\x031,0       \x03")
      send_reply(message, "\x031,0 \x03     \x031,0 \x03")
      send_reply(message, "\x031,0 \x03     \x031,0 \x03")
      send_reply(message, "\x031,0 \x03     \x031,0 \x03")
      send_reply(message, "\x031,0       \x03")
    end

  end
end
