class User < AcitveRecord::Base
  has_many :magazines

  has_secure_password
end
