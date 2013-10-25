module ARBookFinder
  module Configuration
    VALID_OPTION_KEYS = [
     :user_type 
    ]

    DEFAULT_USER_TYPE = nil.freeze

    attr_accessor(*VALID_OPTION_KEYS)

    def self.extended(base)
      base.reset
    end

    def configure
      yield self
    end

    def options
      VALID_OPTION_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    def reset
      self.user_type = DEFAULT_USER_TYPE
    end
  end
end
