class CreateTransactionTags < ActiveRecord::Migration[8.0]
  def change
    create_table :transaction_tags do |t|
      t.references :user_transaction
      t.references :tag
      t.timestamps
    end
  end
end
