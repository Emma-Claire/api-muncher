require 'recipe_search'

class RecipesController < ApplicationController

  def index
    @recipes = Recipe.search_result(params[:search])
  end

  def show
    @recipe = Recipe.show_recipe(params[:recipe])

  end
end
