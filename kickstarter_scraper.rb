require "nokogiri"
require "pry"

  # return a title
  # project.css("h2.bbcard_name strong a").text
  # return image src 
  # project.css('img').first.attribute("src").value
  # retun description 
  # project.css("p").text
  # return location 
  # project.css(".location-name").text
  # return percent
  # project.css("li.first strong").text.gsub("%","").to_i
  
def create_project_hash
  doc = Nokogiri::HTML(open("fixtures/kickstarter.html"))
  new_doc = doc.css(".project.grid_4")
  projects = {}
  new_doc.each{ |project| 
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {  
      image_link: project.css('img').first.attribute("src").value,
      description: project.css("p").text,
      location: project.css(".location-name").text,
      percent_funded: project.css("li.first strong").text.gsub("%","").to_i
    } 
    
  }
  projects

end
create_project_hash
