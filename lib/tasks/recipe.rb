class Recipe
  class RecipeException < StandardError
  end

  BASE_URL = "https://api.edamam.com/search"

  #  attr_reader #recipe attributes to show on page

  def initialize()
    # photo, recipe title, link
  end

  def self.get(uri)
    query_params = {
      "app_id" => ENV["EDAMAM_APPLICATION_ID"],
      "app_key" => ENV["EDAMAM_APPLICATION_KEY"],
      "r" => uri
    }

    recipe = HTTParty.get(BASE_URL, query: query_params).parsed_response
    return recipe["label"]
  end

  def self.find(keyword) #or search_result?

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
    puts recipe_array
  end
end
