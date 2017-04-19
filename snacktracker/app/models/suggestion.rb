class Suggestion < ActiveRecord::Base
  belongs_to :optional_snack
  has_many :votes
  scope :this_month, -> {where(:created_at => Date.today.beginning_of_month.in_time_zone..Time.current)} 

end
