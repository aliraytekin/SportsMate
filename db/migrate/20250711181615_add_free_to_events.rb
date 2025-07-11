class AddFreeToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :free, :boolean, default: true
  end
end
