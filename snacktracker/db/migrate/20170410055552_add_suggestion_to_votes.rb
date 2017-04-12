class AddSuggestionToVotes < ActiveRecord::Migration
  def change
    add_reference :votes, :suggestion, index: true, foreign_key: true
  end
end
