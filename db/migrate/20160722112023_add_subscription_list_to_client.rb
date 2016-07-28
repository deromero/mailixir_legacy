class AddSubscriptionListToClient < ActiveRecord::Migration[5.0]
  def change
    add_column :subscription_lists, :client_id, :integer
    add_index 'subscription_lists', ['client_id'], :name => 'index_subscription_list_client_id'
  end
end
