class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.references :user, index: true, foreign_key: true
      t.interger :action_type
      t.interger :target_id

      t.timestamps
    end
  end
end
