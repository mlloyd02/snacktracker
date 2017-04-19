class SuggestionsController < ApplicationController

  #creates a new suggestion when user selects a snack from dropdown on Suggestions page
  def create
    selected_snack = OptionalSnack.find params[:optional_snack_id]
    selected_snack.suggestions.create
    cookies[:has_suggested] = CookieService.suggestion_cookie #sets cookie value to "true"
    redirect_to optional_snacks_path
  end

end
