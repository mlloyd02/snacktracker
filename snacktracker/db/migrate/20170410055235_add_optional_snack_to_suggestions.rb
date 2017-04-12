class AddOptionalSnackToSuggestions < ActiveRecord::Migration
  def change
    add_reference :suggestions, :optional_snack, index: true, foreign_key: true
  end
end
