require "date"
require "net/imap"
module ImapTickler
  class Tickler
    attr_reader :config
    def initialize(config)
      @day_list = ["Week 1/1", "Week 1/2", "Week 1/3", "Week 1/4", "Week 1/5", "Week 1/6", "Week 1/7", "Week 2/8", "Week 2/9",
        "Week 2/10", "Week 2/11", "Week 2/12", "Week 2/13", "Week 2/14", "Week 3/15", "Week 3/16", "Week 3/17", "Week 3/18",
        "Week 3/19", "Week 3/20", "Week 3/21", "Week 4/22", "Week 4/23", "Week 4/24", "Week 4/25", "Week 4/26", "Week 4/27", 
        "Week 4/28", "Week 5/29", "Week 5/30", "Week 5/31"]

      @month_list = ["Month/01 Jan", "Month/02 Feb", "Month/03 Mar", "Month/04 Apr", "Month/05 May", "Month/06 Jun", 
        "Month/07 Jul", "Month/08 Aug", "Month/09 Sep", "Month/10 Oct", "Month/11 Nov", "Month/12 Dec"]
      
      @config = config
    end

    def connect
      @imap = Net::IMAP.new(config[:mailserver], 993, true) if config[:use_ssl]
      @imap ||= Net::IMAP.new(config[:mailserver])
      if @imap
        @imap.login(config[:username],config[:password])
      end
    end
  
    def this_months_mailbox
      @month_list[Date.today.month - 1]
    end
  
    def todays_mailbox
      @day_list[Date.today.day - 1]
    end
  end
end
