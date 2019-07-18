require 'rubygems'
require 'nokogiri'
require 'open-uri' #open online webpage

# ----------------

def get_townhall_urls # -- récupère les URLs de chaque ville du Val d'Oise
	
	# First, select department 13 | Bouches-du-Rhône
	department_array = []

	page_france = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com/"))
	# retrieve required department in tab city_department
	recup_department = page_france.xpath('//a[contains(@href, "bouches-du-rhone.html")]')
	recup_department.each do |node|
 		department_array << node.text
 		end

 	department_name = department_array[0].downcase.gsub("ô","o").split(" ")
	page_url_department = "http://www.annuaire-des-mairies.com/" + department_name[2] + ".html"


	# Second, select each city in department 13 | Bouches-du-Rhône
	city_name_array = []
	city_html_array = []

	page_department = Nokogiri::HTML(open(page_url_department))
	# retrieve all city in tab city_name_array
	# retrieve all hyperlink html in tab city_html_array
	recup_city = page_department.xpath('//a[@class="lientxt"]') 
	recup_city.each do |node|
 		city_name_array << node.text
 		city_html_array << node["href"][1..-1]
 		end

 	# Build complete html hyperlinks for each cities
 	city_html_array.map! { |html| "http://www.annuaire-des-mairies.com" + html}
 	
 	n = city_html_array.length - 1
 	city_email_array = []
 	# for each city, return email via method get_townhall_email(page_url_town), store email in tab city_email_array
 	for i in (0..n)
 		city_email_array << get_townhall_email(city_html_array[i])
 	end

 	#gather city name and city email in a hash city_name_email_hash
 	city_name_email_hash = city_name_array.zip(city_email_array).to_h

 	puts city_name_email_hash

end


# ---------------------

def get_townhall_email(page_url_town) # -- obtenir un e-mail de mairie à partir de la page de cette dernière

	email_array = []
	page = Nokogiri::HTML(open(page_url_town))

	recup_email = page.xpath('//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
	recup_email.each do |node|
 		email_array << node.text
 	end

	return email_array[0]

end

# '//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]'
# '//*[text()[contains(., "@")]]'

# ----------------

def perform
	get_townhall_urls
end

# ----------------

perform



