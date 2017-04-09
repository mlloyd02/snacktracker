class SuggestionsController < ApplicationController

  def new

  end

  def index
  end

  def create
    suggestion = Suggestion.new(sug_params)
    suggestion.send
  end

  def sug_params
    params.require(:suggestion).permit(:name, :location)
  end

end
