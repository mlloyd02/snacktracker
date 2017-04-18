class OptionalSnack < ActiveRecord::Base
  has_many :suggestions
  validates :name, uniqueness: { case_sensitive: false }
  validates :name, :location, presence: true

  attr_accessor :location

  def after_initialize(location)
    @location = location
  end

  def self.snacks_suggested_this_month
    this_month_sug_ids = Suggestion.this_month.pluck(:optional_snack_id)
    where('id' => this_month_sug_ids).sort_by{ |snack| snack.this_month_sug.created_at}
  end

  def self.snacks_not_yet_suggested
    this_month_sug_ids = Suggestion.this_month.pluck(:optional_snack_id)
    where.not('id' => this_month_sug_ids)
  end

  def this_month_sug
    self.suggestions.this_month.first
  end

  def votes
    this_month_sug.votes.count
  end

end
