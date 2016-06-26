class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :external_id, null: false
      t.string :name, null: false
      t.timestamps null: false
    end
    add_index :channels, :external_id, unique: true
    add_index :channels, :name
  end
end
