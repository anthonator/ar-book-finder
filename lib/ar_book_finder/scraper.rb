module ARBookFinder
  class Scraper
    def initialize(user_type)
      UserTypeProcessor.new(user_type).process
    end

    def search(query, page = 1, sort_by = 'Relevance')
      QuickSearchProcessor.new(query, page, sort_by).process
      SearchResultsParser.new(Capybara.page.html).parse
    end
    
    def collection(collection)
      CollectionProcessor.new(collection).process
      SearchResultsParser.new(Capybara.page.html, true).parse
    end
  end
end
