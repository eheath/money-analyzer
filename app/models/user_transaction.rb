class UserTransaction < ApplicationRecord
  belongs_to :user
  has_many :transaction_tags
  has_many :tags, through: :transaction_tags
  before_save :squish_description

  def squish_description
    self.description = self.description.squish
  end
end