module ARBookFinder
  class QuickSearchProcessor
    include Capybara::DSL
    
    QUICK_SEARCH_URL = "#{ARBookFinder::BASE_URL}/default.aspx"

    def initialize(query)
      @query = query
    end

    def process
      unless current_url.downcase == QUICK_SEARCH_URL
        visit(QUICK_SEARCH_URL)
      end
      fill_in('ctl00_ContentPlaceHolder1_txtKeyWords', with: @query)
      click_button('ctl00_ContentPlaceHolder1_btnDoIt')
    end
  end
end
