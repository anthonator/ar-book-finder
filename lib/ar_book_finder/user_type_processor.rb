module ARBookFinder
  class UserTypeProcessor
    include Capybara::DSL
    
    USER_TYPE_URL = "#{ARBookFinder::BASE_URL}/usertype.aspx"

    USER_TYPES = {
      student: 'Student',
      parent: 'Parent',
      teacher: 'Teacher',
      librarian: 'Librarian'
    }

    def initialize(user_type)
      @user_type = USER_TYPES[user_type]
    end

    def process
      visit(USER_TYPE_URL)
      choose(@user_type)
      click_button('Submit')
    end
  end
end
