class User < ApplicationRecord
  # has_many :games
  # figure out how to say that a user has many games under one of several aliases

  has_secure_password
end
