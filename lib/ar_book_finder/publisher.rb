module ARBookFinder
  class Publisher
    attr_reader :name, :lccn, :isbn, :year_published,
                :page_count

    def initialize(parsed_data)
      load(parsed_data)
    end

    private
    def load(parsed_data)
      parsed_data.keys.each do |k|
        instance_variable_set("@#{k}", parsed_data[k])
      end
    end
  end
end
