module ARBookFinder
  class QuickSearchProcessor
    include Capybara::DSL
    
    QUICK_SEARCH_URL = "#{ARBookFinder::BASE_URL}/default.aspx"

    def initialize(query, page, sort_by)
      @query = query
      @page = page
      @sort_by = sort_by
    end

    def process
      unless current_url.downcase == QUICK_SEARCH_URL
        visit(QUICK_SEARCH_URL)
      end
      fill_in('ctl00_ContentPlaceHolder1_txtKeyWords', with: @query)
      click_button('ctl00_ContentPlaceHolder1_btnDoIt')
      if @page > 1 || @sort_by != PaginationProcessor::DEFAULT_SORT_BY
        PaginationProcessor.new(@page, @sort_by).process
      end
    end
  end
end
