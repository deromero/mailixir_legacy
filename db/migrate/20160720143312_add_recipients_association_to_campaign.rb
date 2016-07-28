class AddRecipientsAssociationToCampaign < ActiveRecord::Migration[5.0]
  def change
    add_column :recipients, :campaign_id, :integer
    add_index 'recipients', ['campaign_id'], :name => 'index_recipients_campaign_id'

  end
end
