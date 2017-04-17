class OptionalSnack < ActiveRecord::Base
  has_many :suggestions
  # accepts_nested_attributes_for :suggestions

  attr_accessor :location

  def after_initialize(name, location)
    @location = location
  end

  def this_month_sug
    self.suggestions.where(:created_at => Date.today.beginning_of_month.in_time_zone..Time.current).first
  end

  def votes
    this_month_sug.votes.count
  end

end
