class FixCampaignStructure < ActiveRecord::Migration[5.0]
  def change
    change_table :campaigns do |t|
      t.remove :description
      t.string :subject, default:  "", null: false
      t.string :from_email, default:  "", null: false
      t.string :from_name, default:  "", null: false
      t.string :reply_to, default:  "", null: false
      t.integer :status, default:  0, null: false
      t.string :send_report_to
      t.datetime :scheduled_on
      t.datetime :sending_started_on
      t.datetime :sent_on
      t.datetime :retry_started_on
    end
  end
end
