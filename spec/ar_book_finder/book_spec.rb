require 'spec_helper'

describe ARBookFinder::Book do
  describe 'fetch' do
    it 'should return book details' do
      book = ARBookFinder.search('978-0590353403').books[0]
      book.fetch.title.should == "Harry Potter and the Sorcerer's Stone"
    end
  end
end
