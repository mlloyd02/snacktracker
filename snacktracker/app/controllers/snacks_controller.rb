class SnacksController < ApplicationController

  def index
    snacks = Snack.new
    @optional_snacks = snacks.get_optional
    @required_snacks = snacks.get_required
  end

  def new
    @suggestion = Snack.new
  end

end
