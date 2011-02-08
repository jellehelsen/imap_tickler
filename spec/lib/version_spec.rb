require "spec_helper"
describe "version" do 
  it "equals 0.0.1" do
    ImapTickler::VERSION.should == "0.0.1"
  end
end
