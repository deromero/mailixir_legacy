class CreateRecipients < ActiveRecord::Migration[5.0]
  def change
    create_table :recipients do |t|
      t.string :name
      t.string :email
      t.string :comments
      t.integer :click_count
      t.datetime :click_on
      t.text :dsn
      t.integer :open_count
      t.datetime :open_on
      t.datetime :sent_on
      t.datetime :bounce_on
      t.boolean :was_clicked
      t.boolean :was_opened
      t.boolean :was_sent
      t.boolean :was_failed
      t.boolean :was_parsed
      t.datetime :parsed_on

      t.timestamps
    end
  end
end
