module ARBookFinder
  class BookDetailProcessor
    include Capybara::DSL

    def initialize(url)
      @url = url
    end

    def process
      visit(@url)
    end
  end
end
