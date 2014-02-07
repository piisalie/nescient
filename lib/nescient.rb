require_relative "nescient/connection"
require_relative "nescient/bot"
require_relative "nescient/message"
require_relative "nescient/action"
require_relative "nescient/login_action"
require_relative "nescient/ping_action"
require_relative "nescient/github_lookup_action"
require_relative "nescient/butts_action"


module Nescient
  def self.run(argv)
    options        = parse_options(argv)
    server         = options[:server]
    port           = options[:port]
    ssl            = options[:ssl]

    connection     = Connection.new(server, port, ssl)
    bot            = Bot.new(connection)
    bot.listen_for(LoginAction.new(options[:bot_name], options[:room]))
    bot.listen_for(PingAction.new)
    bot.listen_for(GithubLookupAction.new)
    bot.listen_for(CloudToButts.new)
    bot.listen
  end

  def self.parse_options(args)
    require "optparse"

    options = {
      bot_name: "Nescient",
      server:   "irc.freenode.net",
      port:     6667,
      ssl:      false,
      room:     "#bottest",
    }

    args.options do |parser|
      parser.banner = "Usage:  #{File.basename($PROGRAM_NAME)} [OPTIONS]"

      parser.separator ""
      parser.separator "Specific Options:"

      parser.on( "-a", "--server ADDRESS",
        "The server address. (default irc.freenode.net)") do |address|
        options[:server] = address
      end


      parser.on( "-p", "--port PORT",
        "Which port to use (default 6667)") do |port|
        options[:port] = port.to_i
      end

      parser.on( "-r", "--room-name NAME",
        "Which room to join (default #bottest)") do |name|
        options[:room] = "##{name}"
      end

      parser.on( "-ssl",
        "Use SSL") do
        options[:ssl] = true
      end

      parser.on( "-b", "--bot-name NAME",
        "The name to use on IRC (default Nescient)" ) do |name|
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
