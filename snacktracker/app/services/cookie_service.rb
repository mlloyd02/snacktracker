class CookieService

  #splits cookie value to get array of suggestion ids that user has voted on
  #To be used in view to disable appropriate vote buttons
  def self.voted_sug_ids_array cookie_val
    if cookie_val
      voted_sug_ids_array = cookie_val.split(/\s*,\s*/)
    else
      voted_sug_ids_array = []
    end
  end

  def self.votes_remaining cookie_val
    voted_sug_ids_array = voted_sug_ids_array cookie_val
    votes = voted_sug_ids_array.count
    votes_remaining = 3 - votes
  end

  #assembles comma separated string of suggestion ids that user has voted on
  def self.create_or_update_votes_cookie cookie_val, sug_id
    if cookie_val
      cookie_to_set = { :value => cookie_val + ',' + sug_id, :expires => beginning_of_next_month }
    else
      cookie_to_set = { :value => sug_id, :expires => beginning_of_next_month }
    end
  end

  #set when user makes a suggestion
  def self.suggestion_cookie
    cookie_to_set = { :value => "true", :expires => beginning_of_next_month }
  end

  def self.beginning_of_next_month
    Date.today.at_beginning_of_month.next_month.in_time_zone
  end

end
