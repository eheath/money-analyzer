class CreateTags < ActiveRecord::Migration[8.0]
  def change
    create_table :tags do |t|
      t.references :user
      t.string :tag, null: false
      t.timestamps
    end
    add_index :tags, :tag, unique: true
  end
end
