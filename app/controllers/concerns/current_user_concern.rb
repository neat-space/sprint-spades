module CurrentUserConcern
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
    before_action :set_current_user
  end

  private

  def set_current_user
    Current.user = current_user
  end
end