require 'rubygems'
require 'nokogiri'
require 'open-uri' #open online webpage

def get_crypto_price

	page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))    

	symbol_array = []
	price_array = []

	# on stocke le symbole de chaque crypto monnaie dans le tableau symbol_array
	symbol = page.xpath('//td[@class="text-left col-symbol"]')
	symbol.each do |node|
	 	symbol_array << node.text
	 end

	# on stocke le prix de chaque crypto monnaie dans le tableau price_array
	price = page.xpath('//a[@class="price"]')
	price.each do |node|
	 	price_array << node.text
	 end

	# on combine les symboles et les prix de chaque crypto monnaie dans un hash crypto_hash
	crypto_price_hash = symbol_array.zip(price_array).to_h
	
	return crypto_price_hash

end

def perform
	get_crypto_price
end

perform