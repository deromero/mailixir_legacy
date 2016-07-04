class AddClientToCampaigns < ActiveRecord::Migration[5.0]
  def change
    add_reference :campaigns, :client, foreign_key: true
  end
end
