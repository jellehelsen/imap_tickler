require "spec_helper"
describe ImapTickler::Tickler do 
  before do
    @tickler = ImapTickler::Tickler.new({})
  end
  it "should get the correct month" do
    Delorean.time_travel_to "5 Jan 2011"
    @tickler.this_months_mailbox.should == "Month/01 Jan"
    Delorean.back_to_the_present
  end
end
