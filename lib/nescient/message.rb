module Nescient
  class Message

    PARSE = /\A(?::(?<prefix>\S+)\s)?
                   (?<command>\S+)
                   (?:\s(?<params>[^:]+))?\s+
                   (?::(?<trailing>.+))?/x

    attr_reader :prefix, :command, :params, :trailing

    def initialize(line)
      @string   = line.to_s
      parse
    end

    def parse
      if (pieces = PARSE.match(@string))
        @prefix   = pieces[:prefix]
        @command  = pieces[:command]
        @params   = pieces[:params]
        @trailing = pieces[:trailing]
      end
    end
    
  end
end
