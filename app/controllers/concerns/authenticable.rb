# helper function to do with auth of user and admin

module Authenticable
  extend ActiveSupport::Concern


  def authenticate_admin!
    authenticate_user!
    redirect_to :somewhere, status: :forbidden unless current_user.admin?
  end
end
