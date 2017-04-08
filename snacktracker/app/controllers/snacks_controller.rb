class SnacksController < ApplicationController

  def index
    snack_list = Snack.new
    @snacks = snack_list.fetch_data
  end

end
