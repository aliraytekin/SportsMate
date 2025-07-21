class AddDifficultyToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :difficulty, :string
  end
end
