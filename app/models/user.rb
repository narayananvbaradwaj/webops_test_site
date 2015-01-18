class User < ActiveRecord::Base
    before_save { self.roll = self.roll.downcase }
    VALID_ROLL_REGEX = /\A[\w+\-.]+[a-z\d\-.]+[\d]+\z/i
    validates :roll,    presence:true,
                        length: { is: 8 },
                        format: { with: VALID_ROLL_REGEX },
                        uniqueness: { case_sensitive: false }
end