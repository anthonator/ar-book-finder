module ARBookFinder
  class PaginationProcessor
    include Capybara::DSL

    DEFAULT_SORT_BY = 'Relevance'

    SORT_BY_TYPES = {
      title: 'Title',
      author: 'Author',
      interest_level: 'Interest Level',
      book_level: 'Book Level',
      relevance: 'Relevance',
      rating: 'Rating'
    }

    def initialize(page, sort_by)
      @page = page
      @sort_by = SORT_BY_TYPES[sort_by]
    end

    def process
      fill_in('ctl00_ContentPlaceHolder1_ucSeachResults_txtPageToGoToTop', with: @page)
      select(@sort_by, from: 'ctl00_ContentPlaceHolder1_ucSeachResults_lstSortOptionListTop')
      click_button('ctl00_ContentPlaceHolder1_ucSeachResults_btnGoToPageTop')
    end
  end
end
