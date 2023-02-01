class ApplicationController < ActionController::Base
  include DeviseWhitelist
  include Pundit::Authorization
  
  before_action :authenticate_user!
end
