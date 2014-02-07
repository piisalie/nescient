module Nescient
  class CloudToButts < Action
    WORDS = %w[ butts webscale potato ]

    def handle?(message)
      if message.command == "PRIVMSG" and
          message.params.last.include?("cloud")
        :exclusve
      else
        false
      end
    end

    def process(message)
      text = message.params.last
      text.gsub!(/cloud/, WORDS.sample)
      send_reply(message, text)
    end

  end
end
