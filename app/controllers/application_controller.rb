class ApplicationController < ActionController::Base
  include DeviseWhitelist
  include Pundit::Authorization
  include CurrentUserConcern

  private
    
    def pundit_user
      Current.user
    end
end
