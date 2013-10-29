module ARBookFinder
  class Scraper
    def initialize(user_type)
      UserTypeProcessor.new(user_type).process
    end

    def search(query, page = 1)
      QuickSearchProcessor.new(query).process
      results = SearchResultsParser.new(Capybara.page.html).parse
      if page > 1
        results = paginate(page, false)
      end
      results
    end
    
    def collection(collection, page = 1)
      CollectionProcessor.new(collection).process
      results = SearchResultsParser.new(Capybara.page.html, true).parse
      if page > 1
        results = paginate(page, true)
      end
      results
    end
    
    private
    def paginate(page, collection) 
      PaginationProcessor.new(page, collection).process
      SearchResultsParser.new(Capybara.page.html, collection).parse
    end
  end
end
