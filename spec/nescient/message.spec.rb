require_relative '../helper'

describe Nescient::Message do

  let(:first_message) { ":hitchcock.freenode.net NOTICE * :*** Looking up your hostname...\r\n" }
  let(:welcome)       { ":hitchcock.freenode.net 001 Nescient :Welcome to the freenode Internet Relay Chat Network Nescient\r\n" }
  let(:ping)          { "PING :hitchcock.freenode.net\r\n" }
  let(:privmsg)       { ":piisalie!~piisalie@192.168.1.1 PRIVMSG #bottest :hello Nescient\r\n" }

  def parse(line)
    Nescient::Message.new(line)
  end

  it 'parses the prefix' do
    parse(first_message).prefix.must_equal('hitchcock.freenode.net')
  end

  it 'parses the command' do
    parse(first_message).command.must_equal('NOTICE')
    parse(welcome).command.must_equal('001')
  end

  it 'parses the params' do
    params = parse(first_message).params
    params.size .must_equal(2)
    params.class.must_equal(Array)
    params.first.must_equal("*")
    params.last .must_equal("*** Looking up your hostname...")
  end

  it 'can parse a welcome message' do
    msg = parse(welcome)
    msg.prefix.must_equal('hitchcock.freenode.net')
    msg.command.must_equal('001')
    msg.params.first.must_equal('Nescient')
    msg.params.last.must_equal('Welcome to the freenode Internet Relay Chat Network Nescient')
  end

  it 'can parse a ping message' do
    msg = parse(ping)
    msg.prefix.must_equal(nil)
    msg.command.must_equal('PING')
    msg.params.size.must_equal(1)
    msg.params.first.must_equal('hitchcock.freenode.net')
  end

  it 'can parse a privmsg' do
    msg = parse(privmsg)
    msg.prefix.must_equal('piisalie!~piisalie@192.168.1.1')
    msg.command.must_equal('PRIVMSG')
    msg.params.first.must_equal('#bottest')
    msg.params.last.must_equal('hello Nescient')
  end

end
