module DeviseCodeAuthenticatable
  module LoginCode
    extend ActiveSupport::Concern

    included do
      belongs_to :user

      after_initialize :default_values
    end

    def default_values
      self.code           ||= rand(10000..99999)
      self.expired        ||= false
      self.retry_times    ||= 0
      self.deliver_method ||= "email"
    end

    def verify(code)
      if expired?
        raise ActiveModel::Errors "expired code should never be validated!"
      end

      self.retry_times += 1; save
      self.code == code
    end

    def expired?
      retry_time_limit = 5
      expire_at = (self.created_at || Time.now) + 10.minutes

      self.expired = self.expired || Time.now.after?(expire_at) || self.retry_times.to_i > retry_time_limit
    end

    def expire_now
      self.expired = true; save
    end

  end
end
