require 'strscan'

module Nescient
  class Message
    attr_reader :prefix, :command, :params, :trailing

    def initialize(line)
      @scanner = StringScanner.new(line.to_s)
      parse(@scanner)
    end

    def parse(scanner)
      parse_prefix(scanner)
      parse_command(scanner)
      parse_params(scanner)
      @trailing = @params.last
    end

    def parse_prefix(scanner)
      scanner.scan(/:(\S+)\s+/)
      @prefix = scanner[1]
    end

    def parse_command(scanner)
      scanner.scan(/([0-9a-zA-Z]+)\s*/)
      @command = scanner[1]
    end

    def parse_params(scanner)
      @params = [ ]
      while param = scanner.scan(/([^:\s]\S*)\s+|:([^\r\n]+)\r?\n?\z/)
        param = scanner[1] || scanner[2]
        @params << param
      end
    end
  end
end
