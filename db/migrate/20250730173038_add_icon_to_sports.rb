class AddIconToSports < ActiveRecord::Migration[7.1]
  def change
    add_column :sports, :icon, :string
  end
end
