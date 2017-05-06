require 'httparty'

class Recipe
  class RecipeException < StandardError
  end

  BASE_URL = "https://api.edamam.com/search?"

  attr_reader :label, :image, :id, :source, :ingredients, :ingredientlines, :nutrition

  def initialize(recipe_params)
    @label = recipe_params[:label]
    @image = recipe_params[:image]
    @id = recipe_params[:id]
    @source = recipe_params[:source]
    @ingredientlines = recipe_params[:ingredientlines]
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
      recipe_id_from_uri = recipe["recipe"]["uri"].split("_").last
      recipe_data = {label: recipe["recipe"]["label"], image: recipe["recipe"]["image"], id: recipe_id_from_uri}  #ask someone about how to get id from uri using gsub
      recipe_array << Recipe.new(recipe_data)

    end
    return recipe_array
  end

  def self.show_recipe(recipe_id_from_uri)
    query_params = {
      "app_id" => ENV["EDAMAM_APPLICATION_ID"],
      "app_key" => ENV["EDAMAM_APPLICATION_KEY"],
      "q" => recipe_id_from_uri
    }

    search_result = HTTParty.get(BASE_URL, query: query_params).parsed_response["hits"]

    show_recipe = {}

    show_recipe[:label] = search_result[0]["recipe"]["label"]

    show_recipe[:image] = search_result[0]["recipe"]["image"]

    show_recipe[:ingredients] = search_result[0]["recipe"]["ingredients"]

    show_recipe[:ingredientlines] = search_result[0]["recipe"]["ingredientlines"]

    show_recipe[:source] = search_result[0]["recipe"]["source"]

    show_recipe[:nutrition] = search_result[0]["recipe"]["nutrition"]

    show_recipe[:uri] = search_result[0]["recipe"]["id"] #should I add url here?
    #ask whether I can skip nutrients

    return Recipe.new(show_recipe)
  end
end
