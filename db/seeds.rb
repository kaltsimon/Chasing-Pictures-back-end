require 'open-uri'

YAML::load_file(File.dirname(__FILE__) + '/seed_data.yml').each do |item|
  place = Place::where(item.except(:picture)).first_or_create
  Picture::where(item[:picture].merge(place: place)).first_or_create do |picture|
    url = item[:picture][:url]
    puts "Downloading #{url}..."

    picture.url = nil
    picture.file = open(URI.encode(url))
  end
end
