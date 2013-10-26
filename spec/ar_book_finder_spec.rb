require 'spec_helper'

describe ARBookFinder do
  describe 'search' do
    it 'should return results' do
      results = ARBookFinder.search('978-0590353403').books
      results.size.should > 0
    end

    it 'should paginate and sort results' do
      results = ARBookFinder.search('harry potter', 2, :title).books
      results.size.should > 0
    end
  end
end
