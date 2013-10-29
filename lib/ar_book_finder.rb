require 'capybara'
require 'capybara/poltergeist'
require 'nokogiri'

require 'ar_book_finder/constants'
require 'ar_book_finder/user_type_processor'
require 'ar_book_finder/pagination_processor'
require 'ar_book_finder/quick_search_processor'
require 'ar_book_finder/collection_processor'
require 'ar_book_finder/book_detail_processor'
require 'ar_book_finder/search_results_parser'
require 'ar_book_finder/book_detail_parser'
require 'ar_book_finder/configuration'
require 'ar_book_finder/scraper'
require 'ar_book_finder/book'
require 'ar_book_finder/publisher'
require 'ar_book_finder/version'

Capybara.current_driver = :poltergeist
Capybara.javascript_driver = :poltergeist

module ARBookFinder
  extend Configuration

  def self.scraper(user_type)
    Scraper.new(user_type)
  end

  def self.search(query, page = 1, sort_by = :relevance)
    scraper(options[:user_type]).search(query, page, sort_by)
  end

  def self.advanced_search(user_type, search_type, params)
    raise 'Not yet implemented'
  end

  def self.collection(collection)
    scraper(options[:user_type]).collection(collection)
  end
end
