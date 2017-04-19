class VotesController < ApplicationController

  def create
    cookie_val = cookies[:voted_sug_ids]
    if CookieService.votes_remaining(votes_cookie_val) <= 0
      flash[:alert] = "You've used all of your votes for the month."
    else
      sug_id = params[:suggestion_id]
      sug = Suggestion.find sug_id
      sug.votes.create
      votes_cookie_val = cookies[:voted_sug_ids]
      cookies[:voted_sug_ids] = CookieService.votes_cookie cookie_val, sug_id
    end
    redirect_to optional_snacks_path
  end

end
