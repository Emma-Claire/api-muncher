require "test_helper"

describe RecipesController do

  describe "index" do
    it "loads and the search page" do
      get root_path
      must_respond_with :success
    end
  end
  describe "search_result" do
    it "loads recipes to recipe_list_path" do

      VCR.use_cassette("search_result") do
        get recipe_list_path, params: {
          "search" => "kale"
        }
      end
      must_respond_with :success
    end
  end
  describe "show" do
    it "shows selected recipe" do
      VCR.use_cassette("show") do
        output = Recipe.search_result("kale")[0]
        get recipe_path(output.label), { "id" => output.id}
      end
      must_respond_with :success
    end
  end
end
