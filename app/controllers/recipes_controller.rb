require_dependency '/../../lib/recipe'

class RecipesController < ApplicationController

  def index

  end

  def search_result #http://stackoverflow.com/questions/18672364/paginating-from-an-api-with-will-paginate-or-kaminari

    if (params[:page].to_i == 1)
      @recipes = Recipe.search_result(params[:search])
      @page = 1
    else
      @page = params[:page].to_i
      from = (@page * 10) - 10
      to = from + 10
      @recipes= Recipe.search_result(params[:search], from, to)
    end
  end

  def show
    @recipe = Recipe.show_recipe(params[:label])
  end
end
