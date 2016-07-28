class FixMailContentsFields < ActiveRecord::Migration[5.0]
  def change
    change_table :mail_contents do |t|
      t.remove :content
      t.remove :content_type
      t.text :html_content, default: "", null: false
      t.text :text_content, default: "", null: false
    end
  end
end
