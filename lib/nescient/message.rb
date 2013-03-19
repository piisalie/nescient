module Nescient
  class Message
    PARSE = /\A(:(?<prefix>\S+)\s)?
                 (?<command>\S+)
                 (?:\s(?<params>[^:\s]+))*
                 (?:\s:(?<trailing>.+))?/x
    attr_reader :prefix, :command, :params, :trailing

    def initialize(line)
      @string   = line.to_s
      @prefix   = @string[PARSE, :prefix]
      @command  = @string[PARSE, :command]
      @params   = @string[PARSE, :params]
      @trailing = @string[PARSE, :trailing]
    end
  end
end
