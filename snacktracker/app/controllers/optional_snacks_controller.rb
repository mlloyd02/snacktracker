class OptionalSnacksController < ApplicationController

  def index
    @this_month_sugs = Suggestion.where(:created_at => Date.today.beginning_of_month..Date.today.end_of_month)
    @required_snacks = ApiService.get_required
  end

  def new
    @snack = OptionalSnack.new
    @suggestion = Suggestion.new
    @suggestions = Suggestion.where("created_at < ?", Date.today.beginning_of_month)
  end

  def create
    name, loc = opt_snack_params[:name], opt_snack_params[:location]
    ApiService.post_new_snack(name, loc)
    ApiService.sync_db

    sug_snack = OptionalSnack.find_by name: name
    sug_snack.suggestions.create
    redirect_to '/optional_snacks'
  end

  private
  def opt_snack_params
    params.require(:optional_snack).permit(:name, :location)
  end

end
