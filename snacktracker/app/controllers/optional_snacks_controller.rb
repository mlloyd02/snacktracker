class OptionalSnacksController < ApplicationController

  def index
    response = ApiService.fetch_data
    if response.success?
      ApiService.sync_db response #syncs API with database
      cookie_val = cookies[:voted_sug_ids]
      @sug_ids = CookieService.voted_sug_ids_array cookie_val #array of suggestion ids optained from cookie. Used to disable appropriate vote buttons
      @votes_remaining = CookieService.votes_remaining cookie_val
      @this_month_sugs = Suggestion.includes(:optional_snack, :votes).this_month
      @required_snacks = ApiService.required_snacks response
    else
      flash.now[:api_error] = ApiService.error_message
    end
  end

  def new
    response = ApiService.fetch_data
    if response.success? && !cookies[:has_suggested] #validates that the API is working and that user has not made a suggestion this month
      ApiService.sync_db response
      @snack = OptionalSnack.new
      @not_suggested_snacks = OptionalSnack.snacks_not_yet_suggested_for_month
    elsif response.success? && cookies[:has_suggested]
      flash.now[:alert] = "You are only allowed one suggestion per month."
    else
      flash.now[:alert] = ApiService.error_message
    end
  end

  #Posts values from new snack form to API and creates new optional snack record in database
  #New suggestions from drowdown handled separately in suggestions controller
  def create
    db_snacks = OptionalSnack.all_snack_names_downcase
    name, loc = opt_snack_params[:name], opt_snack_params[:location]
    if name.present? && loc.present? && !db_snacks.include?(name.downcase) #validates that form values are present and name is unique
      response = ApiService.post_new_snack(name, loc)
      new_snack = OptionalSnack.create(name: response["name"], api_id: response["id"])
      new_snack.suggestions.create 
      cookies[:has_suggested] = CookieService.suggestion_cookie #sets cookie to indicate user has made a suggestion this month
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
