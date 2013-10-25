module ARBookFinder
  class BookDetailParser
    ROOT_XPATH = '//*[@id="ctl00_ContentPlaceHolder1_ucBookDetail_detailTable"]'
    BOOK_XPATH_NODES = {
      cover: '//img[@id="ctl00_ContentPlaceHolder1_ucBookDetail_imgBookCover"]/@src',
      title: 'tbody/tr/td[3]/strong',
      author: '//*[@id="ctl00_ContentPlaceHolder1_ucBookDetail_lblAuthor"]',
      summary: '//*[@id="ctl00_ContentPlaceHolder1_ucBookDetail_lblBookSummary"]',
      ar_quiz_number: '//*[@id="ctl00_ContentPlaceHolder1_ucBookDetail_lblQuizNumber"]',
      language: '//*[@id="ctl00_ContentPlaceHolder1_ucBookDetail_lblLanguageCode"]',
      ar_quiz_availability: '//*[@id="ctl00_ContentPlaceHolder1_ucBookDetail_lblQuizStatusLabel"]',
      atos_book_level: '//*[@id="ctl00_ContentPlaceHolder1_ucBookDetail_lblBookLevel"]',
      interest_level: '//*[@id="ctl00_ContentPlaceHolder1_ucBookDetail_lblInterestLevel"]',
      ar_points: '//*[@id="ctl00_ContentPlaceHolder1_ucBookDetail_lblPoints"]',
      rating: '//*[@id="ctl00_ContentPlaceHolder1_ucBookDetail_lblRanking"]/img/@title',
      word_count: '//*[@id="ctl00_ContentPlaceHolder1_ucBookDetail_lblWordCount"]',
      type: '//*[@id="ctl00_ContentPlaceHolder1_ucBookDetail_lblFictionNonFiction"]',
      topics: '//*[@id="ctl00_ContentPlaceHolder1_ucBookDetail_lblTopicLabel"]',
      series: '//*[@id="ctl00_ContentPlaceHolder1_ucBookDetail_lblSeriesLabel"]'
    }

    ROOT_PUBLISHER_XPATH = '//*[@id="ctl00_ContentPlaceHolder1_ucBookDetail_tblPublisherTable"]/tbody/tr'
    PUBLISHER_XPATH_NODES = {
      name: 'td[1]',
      lccn: 'td[2]',
      isbn: 'td[3]',
      year_published: 'td[4]',
      page_count: 'td[5]'
    }


    def initialize(html)
      @doc = Nokogiri::HTML.parse(html)
      @root = @doc.xpath(ROOT_XPATH)
    end

    def parse
      hash = parse_book_nodes
      hash[:publishers] = parse_publisher_nodes
      hash
    end

    private
    def parse_book_nodes
      hash = {}
      BOOK_XPATH_NODES.keys.each { |k| hash[k] = @root.xpath(BOOK_XPATH_NODES[k]).text.strip }
      hash
    end

    def parse_publisher_nodes
      root = @root.xpath(ROOT_PUBLISHER_XPATH)
      publishers = []
      root.each_with_index do |node, i|
        next if i == 0
        hash = {}
        PUBLISHER_XPATH_NODES.keys.each do |key|
          value = node.xpath(PUBLISHER_XPATH_NODES[key]).text
          value = '' if value == 'Not Available'
          hash[key] = value.strip
        end
        publishers << hash
      end
      publishers
    end
  end
end
