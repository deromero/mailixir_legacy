class CreateSubscribers < ActiveRecord::Migration[5.0]
  def change
    create_table :subscribers do |t|
      t.string :name
      t.string :email
      t.boolean :is_active
      t.integer :bounce_count
      t.text :bounce_comments

      t.timestamps
    end
  end
end
