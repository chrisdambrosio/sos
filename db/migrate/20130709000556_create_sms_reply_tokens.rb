class CreateSmsReplyTokens < ActiveRecord::Migration
  def change
    create_table :sms_reply_tokens do |t|
      t.references :alert, index: true
      t.references :user, index: true
      t.integer :acknowledge_code
      t.integer :resolve_code
      t.string :source_address

      t.timestamps
    end
  end
end
