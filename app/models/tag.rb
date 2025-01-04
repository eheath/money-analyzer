class Tag < ApplicationRecord
  belongs_to :user
  has_many :tag_rules
  validates :tag, presence: true
end