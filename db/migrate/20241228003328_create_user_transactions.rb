class CreateUserTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :user_transactions do |t|
      t.references :user
      t.date :transaction_date
      t.string :description
      t.decimal :debit, precision: 10, scale: 2
      t.decimal :credit, precision: 10, scale: 2
      t.timestamps
    end
  end
end
