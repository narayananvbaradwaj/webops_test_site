class User < ActiveRecord::Base
    validates :roll, length: { is: 8 }
end
