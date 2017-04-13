class Suggestion < ActiveRecord::Base
  belongs_to :optional_snack
  has_many :votes

  def count_votes
    self.votes.count
  end

end
