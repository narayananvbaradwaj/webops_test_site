class User < ActiveRecord::Base
    attr_accessor :remember_token

    before_save { self.roll.downcase! }
    VALID_ROLL_REGEX = /\A[a-zA-Z][a-zA-Z]\d\d[a-z]\d\d\d/i
    validates :roll,    presence:true,
                        length: { is: 8 },
                        format: { with: VALID_ROLL_REGEX },
                        uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, length: { minimum: 6 }
    # Returns the hash digest of the given string.
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ?BCrypt::Engine::MIN_COST :
                                                     BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token) )
    end

    # Returns true if the given token matches the digest.
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    # Forgets a user.
    def forget
        update_attribute(:remember_digest, nil)
    end
end