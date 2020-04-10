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
    doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
    doc
  end 
  
  def get_courses 
    courses = self.get_page.css(".post")
  end
  
  def make_courses
    self.get_courses.collect do |course|
      new_course = Course.new 
      new_course.title = course.css("h2").text.strip
      new_course.schedule = course.css("em").text.strip
      new_course.description = course.css("p").text.strip
    end
  end
end
