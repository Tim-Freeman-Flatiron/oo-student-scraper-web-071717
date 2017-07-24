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
    student = {}
    html = Nokogiri::HTML(open(profile_url))

    soc_media_links = html.css("div.social-icon-container").css('a')

    soc_media_links.each do |link|
      value = link.attribute("href").value
      if value.include?("twitter")
        student[:twitter] = value
      elsif value.include?("github")
        student[:github] = value
      elsif value.include?("facebook")
        student[:facebook] = value
      elsif value.include?("linkedin")
        student[:linkedin] = value
      else
        student[:blog] = value
      end
    end
  student[:profile_quote] = html.css("div.profile-quote").text
  student[:bio] = html.css("div.description-holder p").text
        
  student
  end

end

# puts Scraper.scrape_profile_page('fixtures/student-site/students/aaron-enser.html')
