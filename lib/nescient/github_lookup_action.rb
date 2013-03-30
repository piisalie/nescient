require "open-uri"
require "json"

module Nescient
  class GithubLookupAction < Action
    def handle?(message)
      if message.command == "PRIVMSG" and
         message.params.last.start_with? "!github"
        :exclusive
      else
        false
      end
    end

    def process(message)
      nick = message.params.last[7..-1].strip
      if nick =~ /\S/
        user_data = open("https://api.github.com/users/#{nick}") { |url|
          JSON.parse(url.read)
        }
        avatar = user_data["avatar_url"]
        send_reply(message, "This is #{nick}: #{avatar}")
      else
        send_reply(message, "You must provide a nick to lookup.")
      end
    end
  end
end
