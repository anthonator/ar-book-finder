module ARBookFinder
  class Book
    attr_reader :cover, :title, :author, :summary,
                :ar_quiz_number, :language, :ar_quiz_availability, :atos_book_level,
                :interest_level, :ar_points, :rating, :word_count,
                :type, :topics, :series, :url,
                :publishers

    def initialize(url)
      @url = url
      @publishers = []
    end

    def fetch
      BookDetailProcessor.new(@url).process
      load(BookDetailParser.new(Capybara.page.html).parse)
      self
    end

    private
    def load(parsed_data)
      parsed_data.keys.each do |k|
        instance_variable_set("@#{k}", parsed_data[k]) unless [:ar_quiz_availability,
                                                               :topics,
                                                               :series,
                                                               :publishers].include?(k)
      end

      load_ar_quiz_availability(parsed_data[:ar_quiz_availability])
      load_topics(parsed_data[:topics])
      load_series(parsed_data[:series])
      load_publishers(parsed_data[:publishers])
    end

    def load_ar_quiz_availability(ar_quiz_availability)
      @ar_quiz_availability = ar_quiz_availability.split(',').collect { |v| v.strip }
    end

    def load_topics(topics)
      @topics = topics.split(';').collect do |topic|
        topic.split('-').collect { |v| v.strip }
      end
    end

    def load_series(series)
      @series = series.split(';').collect { |v| v.strip }
    end
    
    def load_publishers(publishers)
      publishers.each { |p| @publishers << Publisher.new(p) }
    end
  end
end
