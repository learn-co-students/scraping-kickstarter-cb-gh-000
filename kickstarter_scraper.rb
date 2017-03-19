# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  # write your code here
  html = File.read('fixtures/kickstarter.html')
  projects = {}

  kickstarter = Nokogiri::HTML(html)
  project_list = kickstarter.css('.project-card')
  project_list.each do |project|
    title = project.css("h2").css("a").text
    img = project.css(".project-thumbnail").css("img").attribute("src").value
    desc = project.css("p.bbcard_blurb").text.strip
    loc = project.css("ul.project-meta span.location-name").text
    funded = project.css("ul.project-stats li.first strong").text.to_i

    projects[title] = {
      image_link: img,
      description: desc,
      location: loc,
      percent_funded: funded
    }
  end
  projects
end

create_project_hash