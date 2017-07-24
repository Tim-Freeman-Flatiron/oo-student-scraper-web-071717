require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

	attr_accessor :name, :location, :profile_url

  def self.scrape_index_page(index_url)
    all_students = []
    html = Nokogiri::HTML(open(index_url))
    profiles = html.css(".student-card")
    
    profiles.each do |profile|
    	student = {
    		:name => profile.css("h4.student-name").text,
    		:location => profile.css("p.student-location").text,
    		:profile_url => profile.css("a").attribute("href").value
    	}
    	
    	all_students << student
    end
    all_students
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

# puts Scraper.scrape_index_page('fixtures/student-site/index.html')
