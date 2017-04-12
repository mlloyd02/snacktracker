class Suggestion < ActiveRecord::Base
  belongs_to :optional_snack
  has_many :votes

  attr_accessor :name, :location

  def count_votes
    self.votes.count
  end

end
