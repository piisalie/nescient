require_relative "nescient/connection"
require_relative "nescient/bot"
require_relative "nescient/message"
require_relative "nescient/loginaction"

module Nescient
  def self.run
    bot            = Bot.new("irc.freenode.net", 6667)
    bot.listen_for = LoginAction.new
    bot.listen
  end
end
