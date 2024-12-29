class Tag < ApplicationRecord
  belongs_to :user
  has_many :tag_rules
end