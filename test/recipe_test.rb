require "simplecov"
SimpleCov.start
require 'test_helper'

describe Recipe do
  before do
    recipe_params= {
      "label" => "Recipe title",
      "image" => "http://www.food.image",
      "id" => "12338947356098373947384658",
      "source" => "someblog",
      "url" => "http://www.someblog.com",
      "ingredients" => ['lemon', 'orange', 'carrot'],
      "yield" => "12",
      "nutrition" => {key: 'value'},
      "calories" => {key: 'value'}
    }
    @recipe = Recipe.new(recipe_params)
  end

  it "needs a hash to initialize" do
    @recipe.class.must_equal Recipe
  end

  it "is able to access info" do
    @recipe.id.must_equal "12338947356098373947384658"
    @recipe.source.must_equal "someblog"
    @recipe.label.must_equal "Recipe title"
  end

  it "returns array of recipe objects" do
    VCR.use_cassette("recipes") do
      ingredient = "kale"
      response = Recipe.search_result(ingredient)
      response.class.must_equal Array
    end
  end

  it "returns an error message if no search word was entered" do
    proc{
      VCR.use_cassette("recipes") do
        response = Recipe.search_result()
      end
    }.must_raise ArgumentError
  end

  it "returns one recipe in the show page" do
    VCR.use_cassette("recipes") do
      search = "kale"
      search_output = Recipe.search_result(search)[0]
      selection_output = Recipe.show_recipe(search_output.id)
      selection_output.class.must_equal Recipe
    end
  end
end
