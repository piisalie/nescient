require_relative "nescient/connection"
require_relative "nescient/bot"
require_relative "nescient/message"
require_relative "nescient/loginaction"


def run
  bot = Nescient::Bot.new("irc.freenode.net", 6667)
  bot.listen_for = Nescient::LoginAction.new
  bot.listen
end
