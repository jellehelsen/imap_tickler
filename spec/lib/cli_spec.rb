require "spec_helper"
require "imap_tickler/cli"
describe ImapTickler::CLI do 
  it "should load the default config file" do
    YAML.expects(:load_file).with(File.expand_path('~/.imap_tickler.conf')).returns(config = mock)
    ImapTickler::Tickler.expects(:new).with(config).returns(tickler = mock(:start => nil))
    ImapTickler::CLI.execute(STDIN,STDOUT,[])
  end

  it "should load the given config file" do
    YAML.expects(:load_file).with(File.expand_path('/tmp/imap_tickler.conf')).returns(config = mock)
    ImapTickler::Tickler.expects(:new).with(config).returns(tickler = mock(:start => nil))
    ImapTickler::CLI.execute(STDIN,STDOUT,%w(-F /tmp/imap_tickler.conf))
  end

  it "should start the tickler" do
    YAML.expects(:load_file).with(File.expand_path('/tmp/imap_tickler.conf')).returns(config = mock)
    ImapTickler::Tickler.expects(:new).with(config).returns(tickler = mock)
    tickler.expects(:start).returns(0)
    ImapTickler::CLI.execute(STDIN,STDOUT,%w(-F /tmp/imap_tickler.conf)).should == 0
  end
end
