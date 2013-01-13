position = 0
File.open("rtr seed", "w") do |output|
  File.open("rtr spoiler") do |file|
    file.each do |line|
      if line.start_with? "Name:"
        position += 1;
        name = line.split(%r{\t})[1].strip.split(%r{[ -]}).each{|word| word.capitalize!}.join(" ").delete(" ',-");
        output << "Card.create({ :name => \""<< name <<"\", :position => \""<< position << "\", :set => 'rtr', :color => 'all'}) \n"
      end
    end
  end
end
