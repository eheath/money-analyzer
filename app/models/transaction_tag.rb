class TransactionTag < ApplicationRecord
  belongs_to :user_transaction
  belongs_to :tag
end