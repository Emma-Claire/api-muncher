require 'httparty'

class Recipe
  class RecipeException < StandardError
  end

  BASE_URL = "https://api.edamam.com/search"

  attr_reader :label, :image, :uri

  def initialize(recipe_params)
    @label = recipe_params[:label]
    @image = recipe_params[:image]
    @uri = recipe_params[:uri]
  end

  def self.search_result(keyword) #or search_result?

    query_params = {
      "app_id" => ENV["EDAMAM_APPLICATION_ID"],
      "app_key" => ENV["EDAMAM_APPLICATION_KEY"],
      "q" => keyword
    }

    search_result = HTTParty.get(BASE_URL, query: query_params).parsed_response["hits"]

    recipe_array = []
    search_result.each do |recipe|
      recipe_data = {label: recipe["recipe"]["label"], image: recipe["recipe"]["image"], uri: recipe["recipe"]["uri"]}
      recipe_array << Recipe.new(recipe_data)
    end
    return recipe_array
  end

  def self.show_recipe(label)
    query_params = {
      "app_id" => ENV["EDAMAM_APPLICATION_ID"],
      "app_key" => ENV["EDAMAM_APPLICATION_KEY"],
      "q" => keyword
    }

    search_result = HTTParty.get(BASE_URL, query: query_params).parsed_response["hits"]

  end
end
