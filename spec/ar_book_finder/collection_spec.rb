require 'spec_helper'

describe 'Collection' do
  it 'should return results for a single child hash' do
    results = ARBookFinder.collection('Awards' => 'ALA Notable/Best Books')
    results.books.size.should > 0
  end
  
  it 'should return results for a multi child hash' do
    results = ARBookFinder.collection('State Lists' => { 'Indiana' => 'IN Young Hoosier Middle Grades Book Award Nominees 2013-2014' })
    results.books.size.should > 0
  end
  
  it 'should fetch book data' do
    results = ARBookFinder.collection('Awards' => 'ALA Notable/Best Books')
    book = results.books[0]
    book.fetch
    book.title.should_not be ''
  end
end
