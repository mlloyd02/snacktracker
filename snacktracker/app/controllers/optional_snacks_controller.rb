class OptionalSnacksController < ApplicationController

  def index
    ApiService.sync_db
    votes_cookie_val = cookies[:voted_sug_ids]
    @sug_ids = CookieService.get_voted_sug_ids_array votes_cookie_val
    @votes_remaining = CookieService.get_votes_remaining votes_cookie_val
    this_month_sug_ids = Suggestion.where(:created_at => Date.today.beginning_of_month.in_time_zone..Time.current).pluck(:optional_snack_id)
    @this_month_snacks = OptionalSnack.where('id' => this_month_sug_ids).sort_by{ |snack| snack.this_month_sug.created_at}
    @required_snacks = ApiService.get_required
  end

  def new
    if cookies[:has_suggested]
      flash.now[:alert] = "You can only suggest one snack per month."
    end
    @snack = OptionalSnack.new
    this_month_sug_ids = Suggestion.where(:created_at => Date.today.beginning_of_month.in_time_zone..Time.current).pluck(:optional_snack_id)
    @not_suggested_snacks = OptionalSnack.where.not('id' => this_month_sug_ids)
  end

  def create
    db_snacks = OptionalSnack.all.pluck(:name).map { |name| name.downcase }
    if opt_snack_params[:name].present? && opt_snack_params[:location].present? && !db_snacks.include?(opt_snack_params[:name].downcase)
      name, loc = opt_snack_params[:name], opt_snack_params[:location]
      ApiService.post_new_snack(name, loc)
      ApiService.sync_db

      sug_snack = OptionalSnack.find_by name: name
      sug_snack.suggestions.create
      cookies[:has_suggested] = { :value => "true", :expires => Date.today.at_beginning_of_month.next_month.in_time_zone }
      redirect_to optional_snacks_path
    elsif opt_snack_params[:name].present? && opt_snack_params[:location].present? && db_snacks.include?(opt_snack_params[:name].downcase)
      flash[:alert] = "A snack by that name already exists."
      redirect_to new_optional_snack_path
    else
      flash[:alert] = "Please include both name and location in your submission."
      redirect_to new_optional_snack_path
    end
  end

  private
  def opt_snack_params
    params.require(:optional_snack).permit(:name, :location, :id)
  end

end
