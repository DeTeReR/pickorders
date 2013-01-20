class GtcController < ApplicationController
  def index
    @cards = Card.where("color = ? and set = 'gtc'", params[:color]).order("position ASC");
  end
  
  def update
    original = Card.where("color = ? and name = ? and set = 'gtc'", params[:color], params[:name]);
	if params[:commit] == '<<'
	  params[:position] = 1
	end
	if params[:commit] == '>>'
	  params[:position] = Card.where("color = ? and set = 'gtc'", params[:color]).order("position ASC")[-1].position;
    end
	if params[:commit] == '<'
	  params[:position] = Integer(params[:position]) - 1
	end
	if params[:commit] == '>'
	  params[:position] = Integer(params[:position]) + 1
    end
	target = Card.where("color = ? and position = ? and set = 'gtc'", params[:color], params[:position]);
    
	if original.length == 1 and target.length ==1
	  original = original[0];
	  target = target[0]
      @message = "original: " + original.name + ", target: " + target.name;
	  if original.position != target.position
		if original.position < target.position
		  #move down
		  for i in original.position+1..target.position
		    Card.where("color = ? and position = ? and set = 'gtc'", params[:color], i)[0].update_attributes(:position => i-1)
		  end
		  original.position = target.position
		  original.save
		else
		  #move up
		  i = original.position
		  while i > target.position
		    Card.where("color = ? and position = ? and set = 'gtc'", params[:color], i-1)[0].update_attributes(:position => i)
		    i -= 1;
		  end
		  original.position = target.position
		  original.save
		end
      end
	end
	
	redirect_to('/gtc/'+params[:color])
  end
end
