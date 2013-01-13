class RtrController < ApplicationController
  def index
    @cards = Card.where("color = ?", params[:color]).order("position ASC");
  end
end
