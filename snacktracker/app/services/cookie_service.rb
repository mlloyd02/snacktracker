class CookieService

  def self.get_voted_sug_ids_array cookie_val
    if cookie_val
      voted_sug_ids_array = cookie_val.split(/\s*,\s*/)
    else
      voted_sug_ids_array = []
    end
  end

  def self.get_votes_remaining cookie_val
    voted_sug_ids_array = get_voted_sug_ids_array cookie_val
    votes = voted_sug_ids_array.count
    votes_remaining = 3 - votes
  end

  def self.create_or_update_vote_cookie cookie_val, sug_id
    if cookie_val
      cookie_to_set = { :value => cookie_val + ',' + sug_id, :expires => Date.today.at_beginning_of_month.next_month.in_time_zone }
    else
      cookie_to_set = { :value => sug_id, :expires => Date.today.at_beginning_of_month.next_month.in_time_zone }
    end
  end

  def self.suggested?
  end



end
