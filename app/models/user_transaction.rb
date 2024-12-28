class UserTransaction < ApplicationRecord
  belongs_to :user
  has_many :transaction_tags
  has_many :tags, through: :transaction_tags
end