class SuggestionsController < ApplicationController

  def create
    selected_snack = OptionalSnack.find params[:optional_snack_id]
    selected_snack.suggestions.create
    cookies[:has_suggested] = { :value => "true", :expires => Date.today.at_beginning_of_month.next_month.in_time_zone }
    redirect_to optional_snacks_path
  end

end
