require 'httparty'

class Recipe
  class RecipeException < StandardError
  end

  BASE_URL = "https://api.edamam.com/search?"

  attr_reader :label, :image, :id, :source, :ingredients, :nutrition, :url, :yield, :calories

  def initialize(recipe_params)
    @label = recipe_params[:label]
    @image = recipe_params[:image]
    @id = recipe_params[:id]
    @source = recipe_params[:source]
    @url = recipe_params[:url]
    @ingredients = recipe_params[:ingredients]
    @yield = recipe_params[:yield]
    @nutrition = recipe_params[:nutrition]
    @calories = recipe_params[:calories]
  end

  def self.search_result(ingredient, from=0, to=9) #or search_result?

    query_params = {
      "app_id" => ENV["EDAMAM_APPLICATION_ID"],
      "app_key" => ENV["EDAMAM_APPLICATION_KEY"],
      "q" => ingredient
    }



    search_result = HTTParty.get(BASE_URL, query: query_params).parsed_response["hits"] #add from to here
    

    recipe_array = []
    search_result.each do |recipe|
      recipe_id_from_uri = recipe["recipe"]["uri"].split("_").last
      recipe_data = {label: recipe["recipe"]["label"], image: recipe["recipe"]["image"], source: recipe["recipe"]["source"], url: recipe["recipe"]["url"], calories: recipe["recipe"]["calories"], yield: recipe["recipe"]["yield"], id: recipe_id_from_uri, ingredients: recipe["recipe"]["ingredients"]}
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

    show_recipe[:ingredients] = search_result[0]["recipe"]["ingredientLines"]

    show_recipe[:yield]= search_result[0]["recipe"]["yield"]
    show_recipe[:source] = search_result[0]["recipe"]["source"]
    show_recipe[:url]= search_result[0]["recipe"]["url"]

    show_recipe[:nutrition] = search_result[0]["recipe"]["totalNutrients"]
    show_recipe[:calories] = search_result[0]["calories"]

    show_recipe[:uri] = search_result[0]["recipe"]["id"] #should I add url here?
    #ask whether I can skip nutrients

    return Recipe.new(show_recipe)
  end
end
