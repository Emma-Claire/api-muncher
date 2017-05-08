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
end

describe "self.search_result" do
  it "requires an argument" do

  end

  it ""
end
