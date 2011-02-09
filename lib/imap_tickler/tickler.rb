require "date"
module ImapTickler
  class Tickler
    def initialize(config)
      @month_list = ["Month/01 Jan", "Month/02 Feb", "Month/03 Mar", "Month/04 Apr", "Month/05 May", "Month/06 Jun", 
        "Month/07 Jul", "Month/08 Aug", "Month/09 Sep", "Month/10 Oct", "Month/11 Nov", "Month/12 Dec"]
      
    end
  
    def this_months_mailbox
      @month_list[Date.today.month - 1]
    end
  end
end
