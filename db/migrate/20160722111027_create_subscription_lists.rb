class CreateSubscriptionLists < ActiveRecord::Migration[5.0]
  def change
    create_table :subscription_lists do |t|
      t.string :name
      t.integer :list_type

      t.timestamps
    end
  end
end
