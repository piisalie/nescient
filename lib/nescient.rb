require_relative "nescient/connection"
require_relative "nescient/bot"
require_relative "nescient/message"
require_relative "nescient/action"
require_relative "nescient/login_action"
require_relative "nescient/ping_action"
require_relative "nescient/github_lookup_action"

module Nescient
  def self.run(argv)
    options        = parse_options(argv)
    connection     = Connection.new("irc.freenode.net")
    bot            = Bot.new(connection)
    bot.listen_for(LoginAction.new(options[:bot_name]))
    bot.listen_for(PingAction.new)
    bot.listen_for(GithubLookupAction.new)
    bot.listen
  end

  def self.parse_options(args)
    require "optparse"

    options = {bot_name: "Nescient"}

    args.options do |parser|
      parser.banner = "Usage:  #{File.basename($PROGRAM_NAME)} [OPTIONS]"

      parser.separator ""
      parser.separator "Specific Options:"

      parser.on( "-b", "--bot-name NAME",
                 "The name to use on IRC." ) do |name|
        options[:bot_name] = name
      end

      parser.separator "Common Options:"

      parser.on( "-h", "--help",
                 "Show this message." ) do
        puts parser
        exit
      end

      begin
        parser.parse!
      rescue OptionParser::ParseError
        puts parser
        exit
      end

      options
    end
  end
end
