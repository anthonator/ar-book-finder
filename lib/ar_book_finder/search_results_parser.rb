module ARBookFinder
  class SearchResultsParser
    PAGE_COUNT_XPATH = '//*[@id="ctl00_ContentPlaceHolder1_ucSeachResults_lblResultsSummaryTop"]'
    RESULTS_XPATH = '//*[@id="ctl00_ContentPlaceHolder1_ucSeachResults_lblQuizzes"]/table'
    BOOK_XPATH = 'tbody/tr/td[2]'
    BOOK_DETAIL_XPATH = 'table/tbody/tr/td[2]'
    BOOK_URL_XPATH = 'a'

    attr_reader :page_count, :books

    def initialize(html)
      @doc = Nokogiri::HTML.parse(html)
      @books = []
    end

    def parse
      @page_count = parse_page_count
      @books = parse_results
      self
    end

    private
    def parse_page_count
      @doc.xpath(PAGE_COUNT_XPATH).text.gsub(/Page \d+ of /, '')
    end

    def parse_results
      books = []
      @doc.xpath(RESULTS_XPATH).each_with_index do |result, i|
        next if i.odd?
        book = result.xpath(BOOK_XPATH)
        book_detail = book.xpath(BOOK_DETAIL_XPATH)
        books << Book.new('http://www.arbookfind.com/' + book_detail.xpath(BOOK_URL_XPATH).attribute('href').content)
      end
      books
    end
  end
end
