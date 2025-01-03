class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_transactions
  has_many :tags
  has_many :transaction_tags, through: :user_transactions

  def tag_transactions(tag, tag_rule)
    user_transactions.each do |trans|
      if trans.description =~ /#{tag_rule.search_string}/i
        trans.transaction_tags.create(tag: tag)
      end
    end
  end

  def tag_totals
    totals = {}
    user_transactions.each do |trans|
      if trans.tags.present?
        trans.tags.each do |tag|
          totals[tag.id] = 0 if totals[tag.id].blank?
          totals[tag.id] += [trans.debit.to_f, trans.credit.to_f].max.abs
        end
      end
    end
    return totals
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
