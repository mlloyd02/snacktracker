class SuggestionsController < ApplicationController

  def index

  end

  def new
    @suggestion = Suggestion.new
    @suggestions = Suggestion.where("created_at < ?", Date.today.beginning_of_month)
  end

  def create
    snack = Snack.new(sug_params)
    snack.post_new_snack
  end

  def create_sug
    binding.pry
    sug = Suggestion.new(params)
    sug.save
  end

  private
  def sug_params
    params.require(:suggestion).permit(:name, :location)
  end

end
