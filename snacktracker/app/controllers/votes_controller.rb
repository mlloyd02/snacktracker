class VotesController < ApplicationController

  def create
    votes_cookie_val = cookies[:voted_sug_ids]
    if CookieService.get_votes_remaining(votes_cookie_val) <= 0
      flash[:alert] = "You don't have any votes left. You can't vote anymore."
    else
      sug_id = params[:suggestion_id]
      sug = Suggestion.find sug_id
      sug.votes.create
      votes_cookie_val = cookies[:voted_sug_ids]
      cookies[:voted_sug_ids] = CookieService.create_or_update_vote_cookie votes_cookie_val, sug_id
    end
    redirect_to '/optional_snacks'
  end

end
