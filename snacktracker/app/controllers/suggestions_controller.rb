class SuggestionsController < ApplicationController

  def index

  end

  def new
    @suggestion = Suggestion.new
    @suggestions = Suggestion.where("created_at < ?", Date.today.beginning_of_month)
  end

  def create
    if params[:id]
      puts params[:id]
    else
      snack = Snack.new(params)
      snack.post_new_snack
    end
  end

  private
  def params
    params.require(:suggestion).permit(:name, :location, :id)
  end

end
