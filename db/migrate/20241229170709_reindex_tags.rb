class ReindexTags < ActiveRecord::Migration[8.0]
  def change
    remove_index :tags, :tag
    add_index :tags, [:user_id, :tag], unique: true
  end
end
