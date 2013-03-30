require 'strscan'

module Nescient
  class Message
    attr_reader :prefix, :command, :params

    def initialize(line)
      @prefix  = nil
      @command = nil
      @params  = [ ]

      parse(StringScanner.new(line.to_s))
    end

    def parse(scanner)
      parse_prefix(scanner)
      parse_command(scanner)
      parse_params(scanner)
    end

    def parse_prefix(scanner)
      if scanner.scan(/:(\S+)\s+/)
        @prefix = scanner[1]
      end
    end

    def parse_command(scanner)
      if scanner.scan(/([0-9a-zA-Z]+)\s*/)
        @command = scanner[1]
      end
    end

    def parse_params(scanner)
      while scanner.scan(/([^:\s]\S*)\s+|:([^\r\n]+)\r?\n?\z/)
        @params << (scanner[1] || scanner[2])
      end
    end
  end
end
