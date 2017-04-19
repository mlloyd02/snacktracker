class CookieService

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

  def self.votes_cookie cookie_val, sug_id
    if cookie_val
      cookie_to_set = { :value => cookie_val + ',' + sug_id, :expires => Date.today.at_beginning_of_month.next_month.in_time_zone }
    else
      cookie_to_set = { :value => sug_id, :expires => Date.today.at_beginning_of_month.next_month.in_time_zone }
    end
  end

  def self.suggestion_cookie
    cookie_to_set = { :value => "true", :expires => Date.today.at_beginning_of_month.next_month.in_time_zone }
  end

end
