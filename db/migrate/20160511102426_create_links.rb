class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.belongs_to :message, index: true
      t.string :url, null: false
      t.string :url_hash, null: false
      t.string :domain, null: false
      t.string :domain_hash, null: false
      t.string :url_id, null: false
      t.string :url_id_hash, null: false
      t.timestamps null: false
    end
    add_index :links, :url_hash
    add_index :links, :url_id_hash
  end
end
