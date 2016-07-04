class FixClientStructure < ActiveRecord::Migration[5.0]
  def change
    change_table :clients do |t|
      t.remove :description
      t.string :contact_name, default: "", null: false
      t.string :contact_email, default: "", null: false
      t.string :country_code, default: "", null: false
      t.integer :time_zone, default:"-5", null: false
    end
  end
end
