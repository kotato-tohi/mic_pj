class CreateStorages < ActiveRecord::Migration[6.1]
  def change
    create_table :storages do |t|
      t.string :name
      t.bigint :owner_id, index: true
      t.timestamps
    end
    add_foreign_key :storages, :users, column: :owner_id
  end
end
