require 'spec_helper'

describe 'Search' do
  it 'should return results for a title search' do
    results = ARBookFinder.search('harry potter')
    results.books.size.should > 0
  end
  
  it 'should fetch book data' do
    results = ARBookFinder.search('harry potter')
    book = results.books[0]
    book.fetch
    book.title.should_not be ''
  end
end
