class OptionalSnacksController < ApplicationController

  def index
    response = ApiService.fetch_data
    if response.success?
      ApiService.sync_db response
      votes_cookie_val = cookies[:voted_sug_ids]
      @sug_ids = CookieService.voted_sug_ids_array votes_cookie_val
      @votes_remaining = CookieService.votes_remaining votes_cookie_val
      @this_month_sugs = Suggestion.includes(:optional_snack, :votes).this_month
      @required_snacks = ApiService.required_snacks response
    else
      flash.now[:api_error] = "There appears to be an issue connecting to the API. Please come back soon to cast your votes and make suggestions!"
    end
  end

  def new
    response = ApiService.fetch_data
    if response.success? && !cookies[:has_suggested]
      ApiService.sync_db response
      @snack = OptionalSnack.new
      @not_suggested_snacks = OptionalSnack.snacks_not_yet_suggested
    elsif response.success? && cookies[:has_suggested]
      flash.now[:alert] = "You are only allowed one suggestion per month."
    else
      flash.now[:alert] = "There appears to be an issue connecting to the API. Please come back soon to cast your votes and make suggestions!"
    end
  end

  def create
    db_snacks = OptionalSnack.all.pluck(:name).map { |name| name.downcase }
    name, loc = opt_snack_params[:name], opt_snack_params[:location]
    if name.present? && loc.present? && !db_snacks.include?(name.downcase)
      ApiService.post_new_snack(name, loc)
      response = ApiService.fetch_data
      ApiService.sync_db response

      sug_snack = OptionalSnack.find_by name: name
      sug_snack.suggestions.create
      cookies[:has_suggested] = CookieService.suggestion_cookie
      redirect_to optional_snacks_path
    elsif name.present? && loc.present? && db_snacks.include?(name.downcase)
      flash[:alert] = "A snack by that name already exists."
      redirect_to new_optional_snack_path
    else
      flash[:alert] = "Please include both name and location in your submission."
      redirect_to new_optional_snack_path
    end
  end

  private
  def opt_snack_params
    params.require(:optional_snack).permit(:name, :location)
  end

end
