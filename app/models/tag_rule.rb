class TagRule < ApplicationRecord
  belongs_to :tag

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