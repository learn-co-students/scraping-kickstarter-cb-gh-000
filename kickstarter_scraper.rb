require "nokogiri"

def create_project_hash
  formatted_projects = {}

  html = File.read("fixtures/kickstarter.html")
  kickstarter = Nokogiri::HTML(html)

  projects = kickstarter.css("li.project.grid_4")

  projects.each do |project|
    formatted_projects.store(project.css("h2.bbcard_name strong a").text, {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurd").text,
      :location => project.css("span.location-name").text,
      :percent_funded => project.css("li.first.funded strong").text.chop.to_i
    })
  end

  formatted_projects
end
