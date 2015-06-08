YAML::load_file(File.dirname(__FILE__) + '/seed_data.yml').each do |item|
  place = Place::where(item.except(:picture)).first_or_create
  Picture::where(item[:picture].merge(place: place)).first_or_create
end
