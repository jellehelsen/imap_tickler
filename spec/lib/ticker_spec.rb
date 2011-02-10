require "spec_helper"
describe ImapTickler::Tickler do 
  before do
    @tickler = ImapTickler::Tickler.new({:mailserver => 'imap.example.com', :username => "user@domain", :password => "secret"})
  end
  it "should get the correct mailbox for this month" do
    Delorean.time_travel_to "5 Jan 2011"
    @tickler.this_months_mailbox.should == "Month/01 Jan"
    Delorean.time_travel_to "5 Feb 2011"
    @tickler.this_months_mailbox.should == "Month/02 Feb"
    Delorean.time_travel_to "5 Dec 2011"
    @tickler.this_months_mailbox.should == "Month/12 Dec"
    Delorean.back_to_the_present
  end

  it "should get the correct mailbox for today" do
    Delorean.time_travel_to "5 Jan 2011"
    @tickler.todays_mailbox.should == "Week 1/5"
    Delorean.time_travel_to "15 Feb 2011"
    @tickler.todays_mailbox.should == "Week 3/15"
    Delorean.time_travel_to "25 Dec 2011"
    @tickler.todays_mailbox.should == "Week 4/25"
    Delorean.back_to_the_present
  end

  it "should conect to the mailserver" do
    Net::IMAP.expects(:new).with('imap.example.com').returns(connection = mock)
    connection.expects(:login).with("user@domain","secret")
    @tickler.connect
  end

  it "should select the mailbox" do
    @tickler.expects(:connection).times(2).returns(connection = mock)
    connection.expects(:select).with("@Tickler/Week 1/5")
    connection.expects(:responses).returns({"EXISTS" => [0]})
    @tickler.tickle_mailbox("Week 1/5")
  end
  
  it "should copy and delete all mails in the mailbox" do
    @tickler.expects(:connection).times(4).returns(connection ||= mock)
    connection.expects(:select).with("@Tickler/Week 1/5")
    connection.expects(:responses).returns({"EXISTS" => [21]})
    connection.expects(:copy).with(1..21,"INBOX")
    connection.expects(:store).with(1..21, "+FLAGS", [:Deleted] )
    @tickler.tickle_mailbox("Week 1/5")
  end
  
  it "should use ssl if instructed" do
    @tickler = ImapTickler::Tickler.new({:mailserver => 'imap.example.com', :username => "user@domain", :password => "secret",:use_ssl => true})
    Net::IMAP.expects(:new).with('imap.example.com', 993, true).returns(connection = mock)
    connection.expects(:login).with("user@domain","secret")
    @tickler.connect
  end

  it "should connect and tickle todays and this months mailbox" do
    Delorean.time_travel_to "5 Jan 2011"
    @tickler.expects(:connect)
    @tickler.expects(:tickle_mailbox).with("Week 1/5")
    @tickler.expects(:tickle_mailbox).with("Month/01 Jan")
    @tickler.start
  end

end
