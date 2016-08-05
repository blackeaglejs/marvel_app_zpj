class MarvelController < ApplicationController

	def index
  		if params[:search]
    	search = params[:search].gsub(' ', '+')
      response = HTTParty.get("http://gateway.marvel.com/v1/public/characters?nameStartsWith=#{search}&ts=1&apikey=5e665d8cd10204f361468c880972d41b&hash=74d6bf483eaaa4692876c00eb0fa9e31")
    	results = JSON.parse(response.body)
    	@results = results['data']['results']
  		else
   		@results = []
  		end
	end

	def show
      @show_id = params['id'].to_i
  		response = HTTParty.get("http://gateway.marvel.com/v1/public/characters/#{@show_id}?ts=1&apikey=5e665d8cd10204f361468c880972d41b&hash=74d6bf483eaaa4692876c00eb0fa9e31")
      result = JSON.parse(response.body)
      @result = result['data']['results']
      @name = result['data']['results'][0]['name']
      @description = result['data']['results'][0]['description']
      @atthtml = result['attributionHTML']
      @comic_listings = []
      @result.each do |result|
        result["comics"]["items"].each do |item|
          @comic_listings.push(item["name"])
        end
      end
      @comic_listings.uniq!
      @comic_listings.sort!
	end

end