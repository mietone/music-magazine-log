class User < ActiveRecord::Base
  has_many :magazines

  has_secure_password
end
