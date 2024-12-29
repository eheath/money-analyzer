class CreateTagRules < ActiveRecord::Migration[8.0]
  def change
    create_table :tag_rules do |t|
      t.references :tag
      t.string :search_string
      t.timestamps
    end
  end
end
