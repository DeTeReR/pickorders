position = 0;
w_position = 0;
u_position = 0;
b_position = 0;
r_position = 0;
g_position = 0;
azorius_pos = 0;
golgari_pos = 0;
izzet_pos = 0;
rakdos_pos = 0;
selesnya_pos = 0;
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
        if color == "W" or (color.include? "W" and hybrid) or color == ""
          w_position += 1;
          output << "Card.create({ :name => \""<< name <<"\", :position => \""<< w_position << "\", :set => 'rtr', :color => 'w'}) \n"
        end
        if color == "U" or (color.include? "U" and hybrid) or color == ""
          u_position += 1;
          output << "Card.create({ :name => \""<< name <<"\", :position => \""<< u_position << "\", :set => 'rtr', :color => 'u'}) \n"
        end
        if color == "B" or (color.include? "B" and hybrid) or color == ""
          b_position += 1;
          output << "Card.create({ :name => \""<< name <<"\", :position => \""<< b_position << "\", :set => 'rtr', :color => 'b'}) \n"
        end
        if color == "R" or (color.include? "R" and hybrid) or color == ""
          r_position += 1;
          output << "Card.create({ :name => \""<< name <<"\", :position => \""<< r_position << "\", :set => 'rtr', :color => 'r'}) \n"
        end
        if color == "G" or (color.include? "G" and hybrid) or color == ""
          g_position += 1;
          output << "Card.create({ :name => \""<< name <<"\", :position => \""<< g_position << "\", :set => 'rtr', :color => 'g'}) \n"
        end
        if color == "WU" or color == "W" or color == "U" or ((color.include? "W" or color.include? "U") and hybrid) or color == ""
          azorius_pos +=1;
          output << "Card.create({ :name => \""<< name <<"\", :position => \""<< azorius_pos << "\", :set => 'rtr', :color => 'azorius'}) \n"
        end
        if color == "BG" or color == "B" or color == "G" or ((color.include? "B" or color.include? "G") and hybrid) or color == ""
          golgari_pos +=1;
          output << "Card.create({ :name => \""<< name <<"\", :position => \""<< golgari_pos << "\", :set => 'rtr', :color => 'golgari'}) \n"
        end
        if color == "UR" or color == "U" or color == "R" or ((color.include? "U" or color.include? "R") and hybrid) or color == ""
          izzet_pos +=1;
          output << "Card.create({ :name => \""<< name <<"\", :position => \""<< izzet_pos << "\", :set => 'rtr', :color => 'izzet'}) \n"
        end
        if color == "BR" or color == "B" or color == "R" or ((color.include? "B" or color.include? "R") and hybrid) or color == ""
          rakdos_pos +=1;
          output << "Card.create({ :name => \""<< name <<"\", :position => \""<< rakdos_pos << "\", :set => 'rtr', :color => 'rakdos'}) \n"
        end
        if color == "GW" or color == "G" or color == "W" or ((color.include? "G" or color.include? "W") and hybrid) or color == ""
          selesnya_pos +=1;
          output << "Card.create({ :name => \""<< name <<"\", :position => \""<< selesnya_pos << "\", :set => 'rtr', :color => 'selesnya'}) \n"
        end
      end
    end
  end
end


#Cost:	 1(B/R)(B/R)
