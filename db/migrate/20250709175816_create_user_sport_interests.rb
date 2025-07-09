class CreateUserSportInterests < ActiveRecord::Migration[7.1]
  def change
    create_table :user_sport_interests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :sport, null: false, foreign_key: true
      t.string :skill_level

      t.timestamps
    end
  end
end
