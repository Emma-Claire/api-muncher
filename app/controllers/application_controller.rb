require_dependency '../../lib/recipe'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
end
