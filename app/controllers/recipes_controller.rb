require_dependency '../../lib/recipe'

class RecipesController < ApplicationController

  def index

  end

  def search_result
    @recipes = Recipe.search_result(params[:search])
  end

  def show
    @recipe = Recipe.show_recipe(params[:label])  #how to assign id?''
  end
end
