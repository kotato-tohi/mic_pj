class CreateLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :links do |t|
      t.references :user, null: false, foreign_key: true
      t.references :storage, null: false, foreign_key: true
      t.boolean :own
      t.boolean :approval

      t.timestamps
    end
  end
end
