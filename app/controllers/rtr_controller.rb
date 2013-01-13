class RtrController < ApplicationController
  def index
    if params[:color]
      @cards = [Card.find(1)] 
    else
      @cards = Card.all
    end
  end
end
