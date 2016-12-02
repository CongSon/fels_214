class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.string :content
      t.boolean :is_correct ,default: false
      t.references :word, foreign_key: true

      t.timestamps
    end
    add_index :answers, [:id, :word_id], unique: true
  end
end
