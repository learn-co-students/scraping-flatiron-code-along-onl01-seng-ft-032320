require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

  def get_page
    html = open("https://learn-co-curriculum.github.io/site-for-scraping/courses") 
    doc = Nokogiri::HTML(html)
  end
  
   def get_courses
    get_page.css(".post") #gets XML elements from page
   end

  def make_courses #iterates through each element and creates a new course instance
    get_courses.each do |c|
      course = Course.new
      course.title = c.css("h2").text
      course.schedule = c.css(".date").text
      course.description = c.css("p").text
    end
  end

end

Scraper.new.print_courses
