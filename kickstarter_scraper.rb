# require libraries/modules here
require 'nokogiri'

def create_project_hash
  # write your code here
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  projects = {}
  htmlobj = kickstarter.css("li.project.grid_4")
  htmlobj.each do |html|
    name = html.css("h2.bbcard_name strong a").text
    projects[name.to_sym] = {
      :image_link => html.css("div.project-thumbnail a img").attribute("src").value,
      :description => html.css("p.bbcard_blurb").text,
      :location =>  html.css("ul.project-meta span.location-name").text,
      :percent_funded => html.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end
  return projects
end
