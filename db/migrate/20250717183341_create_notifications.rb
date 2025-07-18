class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.references :recipient, null: false, foreign_key: { to_table: :users }
      t.references :actor, foreign_key: { to_table: :users }
      t.references :event, foreign_key: true
      t.string :action
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
