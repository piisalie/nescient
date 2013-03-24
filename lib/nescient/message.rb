require 'strscan'

module Nescient
  class Message
    attr_reader :prefix, :command, :params

    def initialize(line)
      @scanner = StringScanner.new(line.to_s)
      parse(@scanner)
    end

    def parse(scanner)
      parse_prefix(scanner)
      parse_command(scanner)
      parse_params(scanner)
    end

    def parse_prefix(scanner)
      @prefix = scanner.scan(/\A:(\S+)\s+/)
    end

    def parse_command(scanner)
      @command = scanner.scan(/\A([0-9a-zA-Z]+)\s+/,)
    end

    def parse_params(scanner)
      @params = [ ]
      while param = scanner.scan(/\A([^:]\S*)\s+|(:.+)\r?\n?/)
        @params << param
      end
    end
  end
end
