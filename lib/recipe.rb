require 'httparty'

class Recipe
  class RecipeException < StandardError
  end

  BASE_URL = "https://api.edamam.com/search?"

  attr_reader :label, :image, :uri, :source, :ingredients, :nutrition, :uri

  def initialize(recipe_params)
    @label = recipe_params[:label]
    @image = recipe_params[:image]
    @uri = recipe_params[:uri]
    @source = recipe_params[:source]
    @ingredients = recipe_params[:ingredients]
    @nutrition = recipe_params[:nutrition]
  end

  def self.search_result(ingredient) #or search_result?

    query_params = {
      "app_id" => ENV["EDAMAM_APPLICATION_ID"],
      "app_key" => ENV["EDAMAM_APPLICATION_KEY"],
      "q" => ingredient
    }

    search_result = HTTParty.get(BASE_URL, query: query_params).parsed_response["hits"]

    recipe_array = []
    search_result.each do |recipe|
      recipe_data = {label: recipe["recipe"]["label"], image: recipe["recipe"]["image"], uri: recipe["recipe"]["uri"]} #.gsub("#", "%23")
      recipe_array << Recipe.new(recipe_data)
    end
    return recipe_array
  end

  def self.show_recipe(uri)
    query_params = {
      "app_id" => ENV["EDAMAM_APPLICATION_ID"],
      "app_key" => ENV["EDAMAM_APPLICATION_KEY"],
      "r" => uri
    }

    search_result = HTTParty.get(BASE_URL, query: query_params)

    show_recipe = {}

  show_recipe[:label] = search_result[0][:label]
  show_recipe[:image] = search_result[0][:image]
  show_recipe[:ingredients] = search_result[0][:ingredientLines]
  show_recipe[:source] = search_result[0][:source] #should I add url here?
  #ask whether I can skip nutrients

return Recipe.new(recipe_info)
  end
end
