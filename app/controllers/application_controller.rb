class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery with: :exception
  $value=0
end
