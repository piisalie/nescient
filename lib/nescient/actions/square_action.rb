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
      color = get_color(message)
      send_reply(message, "\x031,#{color}       \x03")
      send_reply(message, "\x031,#{color} \x03     \x031,#{color} \x03")
      send_reply(message, "\x031,#{color} \x03     \x031,#{color} \x03")
      send_reply(message, "\x031,#{color} \x03     \x031,#{color} \x03")
      send_reply(message, "\x031,#{color}       \x03")
    end

    private

    def get_color(message)
      return 0 if message.params.last.include?("white")
      return 1 if message.params.last.include?("black")
      return 2 if message.params.last.include?("blue")
      return 3 if message.params.last.include?("green")
      return 4 if message.params.last.include?("light_red")
      return 0
    end

  end
end
