module ARBookFinder
  class SearchResultsParser
    SEARCH_ROOT_XPATH = '//*[@id="ctl00_ContentPlaceHolder1_pnlSearchFormPanel"]'
    SEARCH_PAGE_COUNT_XPATH = '//*[@id="ctl00_ContentPlaceHolder1_ucSeachResults_lblResultsSummaryTop"]'
    SEARCH_RESULTS_COUNT = '//*[@id="ctl00_ContentPlaceHolder1_ucSearchResultsHeader_lblResultSummary"]'
    SEARCH_RESULTS_XPATH = '//*[@id="ctl00_ContentPlaceHolder1_ucSeachResults_lblQuizzes"]/table'
    
    COLLECTION_ROOT_XPATH = '//*[@id="ctl00_ContentPlaceHolder1_ucCollection_pnlSearchFormPanel"]'
    COLLECTION_PAGE_COUNT_XPATH = '//*[@id="ctl00_ContentPlaceHolder1_ucCollection_ucSeachResults_lblResultsSummaryTop"]'
    COLLECTION_RESULTS_COUNT = '//*[@id="ctl00_ContentPlaceHolder1_ucCollection_ucSearchResultsHeader_lblResultSummary"]'
    COLLECTION_RESULTS_XPATH = '//*[@id="ctl00_ContentPlaceHolder1_ucCollection_ucSeachResults_lblQuizzes"]/table'
    
    BOOK_XPATH = 'tbody/tr/td[2]'
    BOOK_DETAIL_XPATH = 'table/tbody/tr/td[2]'
    BOOK_URL_XPATH = 'a'

    attr_reader :current_page, :page_count, :total_books, :books

    def initialize(html, collection = false)
      @doc = Nokogiri::HTML.parse(html)
      @xpath_const = collection ? :COLLECTION : :SEARCH
      @root = @doc.xpath(self.class.const_get(:"#{@xpath_const}_ROOT_XPATH"))
      @books = []
    end

    def parse
      @current_page = parse_current_page.to_i
      @page_count = parse_page_count.to_i
      @total_books = parse_total_books.to_i
      @books = parse_results
      self
    end

    private
    def parse_current_page
      @root.xpath(self.class.const_get(:"#{@xpath_const}_PAGE_COUNT_XPATH")).text.gsub(/Page /, '').gsub(/ of \d+/, '')
    end
    
    def parse_page_count
      @root.xpath(self.class.const_get(:"#{@xpath_const}_PAGE_COUNT_XPATH")).text.gsub(/Page \d+ of /, '')
    end
    
    def parse_total_books
      @root.xpath(self.class.const_get(:"#{@xpath_const}_RESULTS_COUNT")).text.gsub(/Titles \d+ - \d+ of /, '')
    end

    def parse_results
      books = []
      @root.xpath(self.class.const_get(:"#{@xpath_const}_RESULTS_XPATH")).each_with_index do |result, i|
        next if i.odd?
        book = result.xpath(BOOK_XPATH)
        book_detail = book.xpath(BOOK_DETAIL_XPATH)
        books << Book.new("#{ARBookFinder::BASE_URL}/#{book_detail.xpath(BOOK_URL_XPATH).attribute('href').content}")
      end
      books
    end
  end
end
