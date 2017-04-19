class OptionalSnack < ActiveRecord::Base
  has_many :suggestions
  validates :name, uniqueness: { case_sensitive: false }, presence: true

  attr_accessor :location

  def after_initialize(location)
    @location = location
  end

  def self.snacks_not_yet_suggested_for_month
    this_month_sug_ids = Suggestion.this_month.pluck(:optional_snack_id)
    where.not('id' => this_month_sug_ids)
  end

  def self.all_snack_names_downcase
    all.pluck(:name).map { |name| name.downcase }
  end

end
