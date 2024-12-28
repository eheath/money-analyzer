class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_transactions
  has_many :tags

  def tag_transactions(tag, substr)
    tag = tags.find_or_create_by(tag: tag)
    user_transactions.each do |trans|
      if trans.description =~ /#{substr}/i
        trans.transaction_tags.create(tag: tag)
      end
    end
  end

  def total_by(tag)
    tag = Tag.find_by_tag(tag)
    total = 0.00
    user_transactions.each do |trans|
      next if trans.tags.detect{ |t| t == tag }.blank?
      if trans.debit.present?
        total = total - trans.debit
      elsif trans.credit.present?
        total += trans.credit
      end
    end
    return total.to_f
  end
end
