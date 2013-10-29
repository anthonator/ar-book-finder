module ARBookFinder
  class SearchResultsParser
    SEARCH_PAGE_COUNT_XPATH = '//*[@id="ctl00_ContentPlaceHolder1_ucSeachResults_lblResultsSummaryTop"]'
    SEARCH_RESULTS_XPATH = '//*[@id="ctl00_ContentPlaceHolder1_ucSeachResults_lblQuizzes"]/table'
    COLLECTION_PAGE_COUNT_XPATH = '//*[@id="ctl00_ContentPlaceHolder1_ucCollection_ucSeachResults_lblResultsSummaryTop"]'
    COLLECTION_RESULTS_XPATH = '//*[@id="ctl00_ContentPlaceHolder1_ucCollection_ucSeachResults_lblQuizzes"]/table'
    
    BOOK_XPATH = 'tbody/tr/td[2]'
    BOOK_DETAIL_XPATH = 'table/tbody/tr/td[2]'
    BOOK_URL_XPATH = 'a'

    attr_reader :page_count, :books

    def initialize(html, collection = false)
      @doc = Nokogiri::HTML.parse(html)
      @xpath_const = collection ? :COLLECTION : :SEARCH
      @books = []
    end

    def parse
      @page_count = parse_page_count
      @books = parse_results
      self
    end

    private
    def parse_page_count
      @doc.xpath(self.class.const_get(:"#{@xpath_const}_PAGE_COUNT_XPATH")).text.gsub(/Page \d+ of /, '')
    end

    def parse_results
      books = []
      @doc.xpath(self.class.const_get(:"#{@xpath_const}_RESULTS_XPATH")).each_with_index do |result, i|
        next if i.odd?
        book = result.xpath(BOOK_XPATH)
        book_detail = book.xpath(BOOK_DETAIL_XPATH)
        books << Book.new("#{ARBookFinder::BASE_URL}/#{book_detail.xpath(BOOK_URL_XPATH).attribute('href').content}")
      end
      books
    end
  end
end
