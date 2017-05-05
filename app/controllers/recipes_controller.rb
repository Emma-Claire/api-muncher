class RecipesController < ApplicationController

  def index

  end

  def search_result
    @recipes = Recipe.search_result(params[:keyword])
    if @recipes.nil?
      head :not_found
    end
  end

  def show
    @recipe = Recipe.show_recipe(params[:uri])  #how to assign id?
  end
end
