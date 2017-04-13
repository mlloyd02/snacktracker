class OptionalSnack < ActiveRecord::Base
  has_many :suggestions
  # accepts_nested_attributes_for :suggestions

  attr_accessor :location

  def after_initialize(name, location)
    @location = location
  end

end
