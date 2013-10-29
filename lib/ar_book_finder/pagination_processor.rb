module ARBookFinder
  class PaginationProcessor
    include Capybara::DSL
    
    SEARCH_GOTO_FIELD = 'ctl00_ContentPlaceHolder1_ucSeachResults_txtPageToGoToTop'
    SEARCH_SUBMIT_BUTTON = 'ctl00_ContentPlaceHolder1_ucSeachResults_btnGoToPageTop'
    
    COLLECTION_GOTO_FIELD = 'ctl00_ContentPlaceHolder1_ucCollection_ucSeachResults_txtPageToGoToTop'
    COLLECTION_SUBMIT_BUTTON = 'ctl00_ContentPlaceHolder1_ucCollection_ucSeachResults_btnGoToPageTop'

    def initialize(page, collection = false)
      @page = page
      @field_const = collection ? :COLLECTION : :SEARCH
    end

    def process
      fill_in(self.class.const_get(:"#{@field_const}_GOTO_FIELD"), with: @page)
      click_button(self.class.const_get(:"#{@field_const}_SUBMIT_BUTTON"))
    end
  end
end
