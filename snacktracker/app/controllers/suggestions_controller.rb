class SuggestionsController < ApplicationController

  def index

  end

  def new
    @suggestion = Suggestion.new
    @suggestions = Suggestion.where("created_at < ?", Date.today.beginning_of_month)
  end

  def create
    if opt_snack_params[:optional_snack_id].present?
      selected_snack = OptionalSnack.find opt_snack_params[:id]
      selected_snack.suggestions.create
      cookies[:has_suggested] = { :value => "true", :expires => Date.today.at_beginning_of_month.next_month.in_time_zone }
      redirect_to optional_snacks_path
    else
      flash[:alert] = "Please select a snack to suggest"
      redirect_to new_optional_snack_path
    end
  end

  private
  def sug_params
    params.require(:suggestion).permit(:optional_snack_id)
  end

end
