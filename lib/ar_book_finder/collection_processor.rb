module ARBookFinder
  class CollectionProcessor
    include Capybara::DSL
    
    COLLECTIONS_URL = "#{ARBookFinder::BASE_URL}/collections.aspx"
    
    def initialize(collections)
      @collections = collections
    end
    
    def process
      unless current_url.downcase == COLLECTIONS_URL
        visit(COLLECTIONS_URL)
      end
      navigate_collection(@collections)
    end
    
    private
    def navigate_collection(collection)
      collection.each do |key, value|
        click_on(key)
        if value.kind_of?(Hash)
          navigate_collection(value)
        else
          click_on(value)
        end  
      end
    end
  end
end