class SnacksController < ApplicationController

  def index
    @suggestions = Suggestion.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)
    @required_snacks = ApiService.get_required
  end

  def new
  end

end
