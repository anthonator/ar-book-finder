module ARBookFinder
  class UserTypeProcessor
    include Capybara::DSL

    def initialize(user_type)
      @user_type = user_type
    end

    def process
      visit('http://www.arbookfind.com/usertype.aspx')
      choose(@user_type)
      click_button('Submit')
    end
  end
end
