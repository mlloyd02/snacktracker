class AddDateToSuggestions < ActiveRecord::Migration
  def change
    add_column :suggestions, :date, :date
  end
end
