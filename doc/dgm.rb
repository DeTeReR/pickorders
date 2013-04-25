c_position = 0;
u_position = 0;
r_position = 0;
name = "";
skip = false;
File.open("dgm seed", "w") do |output|
  File.open("dgm spoiler") do |file|
    file.each do |line|
    
      if line.start_with? "Name"
		skip = false;
        name = line.split(%r{\t})[1].strip.split(%r{[ ]}).each{|word| word.downcase!};
        if name[-1].start_with?('(') then
        	name[-1] = name[-1].delete('()')
        	if name[0] == name[-1] then
        		skip = true;
        		next
        	end
        	name.pop()
        end
#        p name.join(" ")
      end
      
      if line.start_with?("Set/Rarity:") and skip == false
        r_position += 1;
        output << "Card.create({ :name => \""<< name.join(" ") <<"\", :position => \""<< r_position << "\", :set => 'dgm', :color => 'r'}) \n";
        if !line.strip.end_with?("Rare")
          u_position += 1;
          output << "Card.create({ :name => \""<< name.join(" ") <<"\", :position => \""<< u_position << "\", :set => 'dgm', :color => 'u'}) \n"
		    if !line.strip.end_with?("Uncommon")
		      c_position += 1;
		      output << "Card.create({ :name => \""<< name.join(" ") <<"\", :position => \""<< c_position << "\", :set => 'dgm', :color => 'c'}) \n"
		    end
        end
      end
    end
  end
end
