# ARBookFinder

Retrieve book data from [arbookfind.com](http://www.arbookfind.com)

[![Build Status](https://travis-ci.org/anthonator/ar-book-finder.png?branch=master)](https://travis-ci.org/anthonator/ar-book-finder) [![Dependency Status](https://gemnasium.com/anthonator/ar-book-finder.png)](https://gemnasium.com/anthonator/ar-book-finder) [![Coverage Status](https://coveralls.io/repos/anthonator/ar-book-finder/badge.png)](https://coveralls.io/r/anthonator/ar-book-finder) [![Code Climate](https://codeclimate.com/github/anthonator/ar-book-finder.png)](https://codeclimate.com/github/anthonator/ar-book-finder)

## Installation

Add this line to your application's Gemfile:

    gem 'ar_book_finder'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ar_book_finder

### PhantomJS
This gem utilizes [PhantomJS](http://phantomjs.org/) for interacting with [arbookfind.com](http://www.arbookfind.com). Make sure to [install PhantomJS](http://phantomjs.org/download.html) in order to use this gem.

## Configuration
Choose what type of user to peform searches as.

Available types include:
 * ```:student```
 * ```:parent```
 * ```:teacher```
 * ```:librarian```

These types match up to the available user types [here](http://www.arbookfind.com/usertype.aspx).
```ruby
ARBookFinder.configure do |config|
  config.user_type = :teacher
end
```

## What data is returned?
The ARBookFinder gem is capable or returning any data located on a book's [detail](http://www.arbookfind.com/bookdetail.aspx?q=26759&l=EN&slid=431859594) page.

This includes:
 * cover
 * title
 * author
 * summary
 * ar_quiz_number
 * language
 * ar_quiz_availability
 * atos_book_level
 * interest_level
 * ar_points
 * rating
 * word_count
 * type
 * topics
 * series
 * url
 
And publisher details:
 * name
 * lccn
 * isbn
 * year_published
 * page_count

## Usage

### Quick Search
Quick search allows you to perform searches based on title, topics, author or ISBN.

Perform a quick search...
```ruby
results = ARBookFinder.search('harry potter')
results.page_count # Retrieve the number of pages this search returns
results.books # Retrieve the books returned on this page
```
Load book data on demand using ```#fetch```...
``` ruby
...
book = results[0]
book.fetch # Retrieve book data
book.title
book.author
...
```
Return publisher data...
```ruby
...
publisher = book.publishers
publisher.name
publisher.isbn
...
```

### Pagination and Sorting
It's also possible to paginate and sort search results.
```ruby
# Retrieve results for page 2 and sort on title
results = ARBookFinder.Search('harry potter', 2, :title)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits
[![Sticksnleaves](http://sticksnleaves-wordpress.herokuapp.com/wp-content/themes/sticksnleaves/images/snl-logo-116x116.png)](http://www.sticksnleaves.com)

ARBookFinder is maintained and funded by [Sticksnleaves](http://www.sticksnleaves.com)

Thanks to all of our [contributors](https://github.com/anthonator/ar-book-finder/graphs/contributors)
