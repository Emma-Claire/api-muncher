Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'recipes#index'


  get '/recipes', to: 'recipes#search_result', as: 'recipe_list'

  get 'recipes/:label', to: 'recipes#show', as: 'recipe'
end
