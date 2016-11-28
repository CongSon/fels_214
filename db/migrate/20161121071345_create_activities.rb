class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.references :user, index: true, foreign_key: true
      t.string :activityable_type
      t.integer :activityable_id
      t.integer :activity_type

      t.timestamps
    end
  end
end
