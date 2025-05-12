class CreateFeedbacks < ActiveRecord::Migration[8.0]
  def change
    create_table :feedbacks do |t|
      t.references :event, null: false, foreign_key: true
      t.string :user_name, null: false
      t.integer :rating, null: false
      t.text :comment

      t.timestamps
    end
  end
end
