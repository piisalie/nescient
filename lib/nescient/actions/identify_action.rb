module Nescient
  class IdentifyAction < Action
    def handle?(message)
      if message.command == "PRIVMSG" and
          message.params.last.include?("!identify")
        :exclusve
      else
        false
      end
    end

    def process(message)
      send_reply(message, "0% hubot by volume ( https://github.com/piisalie/nescient )")
    end

  end
end
