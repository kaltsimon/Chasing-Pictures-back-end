require 'nokogiri'
require 'open-uri'
require 'digest/md5'

# seems to work http://stackoverflow.com/questions/1026337/how-do-i-get-link-to-an-image-on-wikipedia-from-the-infobox
def commons_page_to_image_url(file_url)
  file_name = file_url[40..-1]
  digest = Digest::MD5.hexdigest(URI.unescape(file_name))

  "http://upload.wikimedia.org/wikipedia/commons/#{digest[0]}/#{digest[0..1]}/#{file_name}"
end

doc = Nokogiri::XML(open('https://offenedaten.de/storage/f/2014-04-06T10%3A06%3A29.535Z/stadtmuseumberlin-stadtansichten.xml')).remove_namespaces!
doc.css('museumdat').each do |item|
  place = Place::where({
    name: item.xpath('.//title[@pref="preferred"]').text,
    description: item.xpath('.//title[@pref="alternate"]').text,
    longitude: 0.0,
    latitude: 0.0
  }).first_or_create

  Picture::where({
    url: commons_page_to_image_url(item.xpath('.//resourceID').text),
    time: Date.new((item.xpath('.//earliestDate').empty? ? item.xpath('.//displayCreationDate').text : item.xpath('.//earliestDate').text).to_i),
    place: place
  }).first_or_create
end
