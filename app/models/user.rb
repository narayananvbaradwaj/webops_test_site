class User < ActiveRecord::Base
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
end