class CreateWords < ActiveRecord::Migration[5.0]
  def change
    create_table :words do |t|
      t.string :content
      t.references :category, foreign_key: true

      t.timestamps
    end
    add_index :words, [:id, :category_id], unique: true
  end
end
