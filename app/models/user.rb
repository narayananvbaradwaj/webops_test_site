class User < ActiveRecord::Base
    before_save { self.roll = self.roll.downcase }
    VALID_ROLL_REGEX = /\A[a-zA-Z][a-zA-Z]\d\d[a-z]\d\d\d/i
    validates :roll,    presence:true,
                        length: { is: 8 },
                        format: { with: VALID_ROLL_REGEX },
                        uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, length: { minimum: 6 }
end