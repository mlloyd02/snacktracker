class VotesController < ApplicationController

  #creates a new vote when user clicks vote button on voting page
  def create
    cookie_val = cookies[:voted_sug_ids]
    if CookieService.votes_remaining(cookie_val) > 0
      sug_id = params[:suggestion_id]
      sug = Suggestion.find sug_id
      sug.votes.create
      votes_cookie_val = cookies[:voted_sug_ids]
      cookies[:voted_sug_ids] = CookieService.create_or_update_votes_cookie cookie_val, sug_id #adds new suggestion id to cookie
    else
      flash[:alert] = "You've used all of your votes for the month."
    end
    redirect_to optional_snacks_path
  end

end
