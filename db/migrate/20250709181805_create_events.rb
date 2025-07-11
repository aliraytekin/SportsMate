class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.references :user, null: false, foreign_key: true
      t.references :sport, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.string :address
      t.string :venue
      t.integer :max_participants
      t.integer :status, null: false, default: 1
      t.float :price_per_participant

      t.timestamps
    end
  end
end
