require "nokogiri"
require "pry"

def create_project_hash
    html = File.read("fixtures/kickstarter.html")
    kickstarter = Nokogiri::HTML(html)
    projects = {}

    kickstarter.css("li.project.grid_4").each do |project|
        projects[project.css("h2.bbcard_name strong a").text.to_sym] = {
            :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
            :description => project.css("p.bbcard_blurb").text.strip,
            :location => project.css("ul.project-meta li a span.location-name").text,
            :percent_funded => project.css("ul.project-stats li strong").text.gsub("%", "").to_i
        }
    end
    projects
end

create_project_hash


# :projects => {
#   "My Great Project"  => {
#     :image_link => "Image Link",
#     :description => "Description",
#     :location => "Location",
#     :percent_funded => "Percent Funded"
#   },
#   "Another Great Project" => {
#     :image_link => "Image Link",
#     :description => "Description",
#     :location => "Location",
#     :percent_funded => "Percent Funded"
#   }
# }