class TagRule < ApplicationRecord
  belongs_to :tag
  before_save :squish_search_string

  def squish_search_string
    self.search_string = self.search_string.squish
  end

  def apply
    tag.user.user_transactions.each do |t|
      if t.description =~ /#{search_string}/i
        if t.transaction_tags.exclude?(tag)
          t.transaction_tags.create(tag: tag)
        end
      end
    end
  end
end