class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :channel, null: false, index: true
      t.belongs_to :user, null: false, index: true
      t.text :body, null: false
      t.string :body_hash, null: false
      t.timestamps null: false
    end
    add_index :messages, :body_hash
  end
end
