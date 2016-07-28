class AddMailContentsAssociationToCampaign < ActiveRecord::Migration[5.0]
  def change
    add_column :mail_contents, :campaign_id, :integer
    add_index 'mail_contents', ['campaign_id'], :name => 'index_campaign_id'
  end
end
