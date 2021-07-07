# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  # write your code here
  result = {}
  html = File.read("./fixtures/kickstarter.html")
  kickstarter = Nokogiri::HTML(html)
  kickstarter.css(".project").each do |html_project|
    project = {
      :image_link => html_project.css(".project-thumbnail").css("img").first['src'],
      :description => html_project.css(".bbcard_blurb").text.strip,
      :location => html_project.css(".location-name").text.strip,
      :percent_funded => html_project.css(".funded").css("strong").text.strip.gsub("%","").to_i
    }
    result[html_project.css(".bbcard_name").css("a").text.strip.to_sym] = project
  end
  result
end
