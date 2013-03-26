require_relative "nescient/connection"
require_relative "nescient/bot"
require_relative "nescient/message"
require_relative "nescient/login_action"

module Nescient
  def self.run
    connection     = Connection.new("irc.freenode.net")
    bot            = Bot.new(connection)
    bot.listen_for = LoginAction.new
    bot.listen
  end
end
