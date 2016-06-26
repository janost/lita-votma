class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :external_id, null: false
      t.string :name, null: false
      t.string :mention_name
      t.timestamps null: false
    end
    add_index :users, :external_id, unique: true
    add_index :users, :name
    add_index :users, :mention_name
  end
end
