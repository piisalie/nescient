module Nescient
  class LoginAction
    def handle?(message)
      return :passthrough if message.command.downcase == "notice" &&
        message.params.last.downcase.include?("checking ident")
    end

    def process(message, connection)
      connection.puts "NICK Nescient"
      connection.puts "USER Nescient 0 * :Nescient Tut"
    end
  end
end
