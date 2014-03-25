module Nescient
  class HubotAction < Action
    def handle?(message)
      if message.command == "PRIVMSG" and
          message.params.last.include?("hubot")
        :exclusve
      else
        false
      end
    end

    def process(message)
      send_reply(message, "My name isn't hubot.")
    end

  end
end
