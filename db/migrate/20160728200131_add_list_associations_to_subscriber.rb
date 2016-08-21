class AddListAssociationsToSubscriber < ActiveRecord::Migration[5.0]
  def change
    add_column :subscribers, :subscription_list_id, :integer
    add_index 'subscribers', ['subscription_list_id'], :name => 'index_subscribers_subscription_list_id'
  end
end
