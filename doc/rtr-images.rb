require 'open-uri'

File.open("rtr spoiler") do |file|
  file.each do |line|
    if line.start_with? "Name:"
      p name = line.split(%r{\t})[1].strip.split(%r{[ -]}).each{|word| word.capitalize!}.join(" ").delete(" ',-");
      open("http://static.starcitygames.com/sales/cardscans/MAG_RTR/" << name << ".jpg") { |f|
        open(name << ".jpg", "wb") { |img|
          img.puts(f.read);
        }
      }
    end
  end
end
