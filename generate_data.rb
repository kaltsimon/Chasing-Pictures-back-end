require 'nokogiri'
require 'open-uri'
require 'digest/md5'
require 'yaml'

GEO_DATA = YAML::load_file (File.dirname(__FILE__) + "/db/geo_data.yml")

# seems to work http://stackoverflow.com/questions/1026337/how-do-i-get-link-to-an-image-on-wikipedia-from-the-infobox
def commons_data(file_url)
  file_name = URI.unescape(file_url.split(/File\:|\//).last)
  digest = Digest::MD5.hexdigest(file_name)

  [file_name, "http://upload.wikimedia.org/wikipedia/commons/#{digest[0]}/#{digest[0..1]}/#{file_name}"]
end

doc = Nokogiri::XML(open('https://offenedaten.de/storage/f/2014-04-06T10%3A06%3A29.535Z/stadtmuseumberlin-stadtansichten.xml')).remove_namespaces!
places, pictures = [], []

doc.css('museumdat').each do |item|
  file_name, image_url = commons_data(item.xpath('.//resourceID').text)

  places << {
    name: item.xpath('.//title[@pref="preferred"]').text,
    description: item.xpath('.//title[@pref="alternate"]').text,
    longitude: GEO_DATA[file_name]['lon'],
    latitude: GEO_DATA[file_name]['lat'],
    picture: {
      url: image_url,
      time: Date.new((item.xpath('.//earliestDate').empty? ? item.xpath('.//displayCreationDate').text : item.xpath('.//earliestDate').text).to_i),
    }
  }
end

puts places.to_yaml
