position = 0;
u_position = 0;
name = "";
hybrid = false;
color = ""
File.open("rtr seed", "w") do |output|
  File.open("rtr spoiler") do |file|
    file.each do |line|
      if line.start_with? "Name:"
        name = line.split(%r{\t})[1].strip.split(%r{[ -]}).each{|word| word.capitalize!}.join(" ").delete(" ',-");
      end
      if line.start_with? "Cost:"
        if line.include? "/"
          hybrid = true;
        else
          hybrid = false;
        end
        color = ""
        line.split("").each{ |char| if char[/[WUBGR]/] and !color.include? char then color << char end};
      end
      if line.start_with?("Set/Rarity:") and !line.strip.end_with?("Rare")
        position += 1;
        output << "Card.create({ :name => \""<< name <<"\", :position => \""<< position << "\", :set => 'rtr', :color => 'all'}) \n";
        if color == "U" or (color.include? "U" and hybrid) or color == ""
          u_position += 1;
          output << "Card.create({ :name => \""<< name <<"\", :position => \""<< u_position << "\", :set => 'rtr', :color => 'U'}) \n"
        end
      end
    end
  end
end


#Cost:	 1(B/R)(B/R)
