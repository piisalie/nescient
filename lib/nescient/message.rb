module Nescient
  class Message

    attr_reader :prefix, :command, :params, :trailing

    def initialize(line)
      @string   = line.to_s
      parse
    end

    def parse
      parse_prefix(@string)
      parse_command(@string)
      parse_params(@string)
      parse_trailing(@string)
    end

    def parse_prefix(string)
      if string.sub!(/\A:(\S+)\s+/,"")
        @prefix = $1
      end
    end

    def parse_command(string)
      if string.sub!(/\A(?:\S+\s)?([^:\s]\S+)/,"")
        @command = $1
      end
    end

    def parse_params(string)
      if string.sub!(//,"")
        @params = $1
      end
    end

    def parse_trailing(string)
      if string.sub!(/\A:?(?:[^:]+)+:(.+)/,,"")
        @trailing = $1
      end
    end
    
  end
end
