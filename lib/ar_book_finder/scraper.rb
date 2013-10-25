module ARBookFinder
  class Scraper
    def initialize(user_type)
      @user_type = user_type
    end

    def search(query, page = 1, sort_by = 'Relevance')
      UserTypeProcessor.new(@user_type).process
      QuickSearchProcessor.new(query, page, sort_by).process
      SearchResultsParser.new(Capybara.page.html).parse
    end
  end
end
