class RemoveDateFromSuggestions < ActiveRecord::Migration
  def change
    remove_column :suggestions, :date, :date
  end
end
