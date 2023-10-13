module DeviseCodeAuthenticatable
  module LoginCode
    extend ActiveSupport::Concern

    included do
      extend ClassMethods
      belongs_to :resource, polymorphic: true

      after_initialize :default_values
    end

    def default_values
      self.code           ||= rand(10000..99999)
      self.expired        ||= false
      self.retry_times    ||= 0
    end

    def verify(code)
      if expired?
        return false
      end

      self.retry_times += 1; save!
      self.code == code
    end

    def used?
      expired
    end

    def expired?
      retry_time_limit = self.class.retry_limit
      expire_at = (self.created_at || Time.now) + self.class.expire_time

      self.expired = self.expired || Time.now.after?(expire_at) || self.retry_times.to_i > retry_time_limit
    end

    def expire_now
      self.expired = true; save
    end

    module ClassMethods
      Devise::Models.config(self, :retry_limit)
      Devise::Models.config(self, :expire_time)
    end

  end
end
