class User < ApplicationRecord
  belongs_to :company, required: false
  has_secure_password




end
