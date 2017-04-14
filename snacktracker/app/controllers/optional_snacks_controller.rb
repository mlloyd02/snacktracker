class OptionalSnacksController < ApplicationController

  def index
    this_month_sug_ids = Suggestion.where(:created_at => Date.today.beginning_of_month..1.day.from_now).pluck(:optional_snack_id)
    @this_month_sugs = OptionalSnack.where('id' => this_month_sug_ids)
    @required_snacks = ApiService.get_required
  end

  def new
    @snack = OptionalSnack.new
    this_month_sug_ids = Suggestion.where(:created_at => Date.today.beginning_of_month..Date.today).pluck(:optional_snack_id)
    @not_suggested_snacks = OptionalSnack.where.not('id' => this_month_sug_ids)
  end

  def create
    if opt_snack_params[:id]
      selected_snack = OptionalSnack.find opt_snack_params[:id]
      selected_snack.suggestions.create
      redirect_to '/optional_snacks'
    else
      name, loc = opt_snack_params[:name], opt_snack_params[:location]
      ApiService.post_new_snack(name, loc)
      ApiService.sync_db

      sug_snack = OptionalSnack.find_by name: name
      sug_snack.suggestions.create
      redirect_to '/optional_snacks'
    end
  end

  private
  def opt_snack_params
    params.require(:optional_snack).permit(:name, :location, :id)
  end

end
