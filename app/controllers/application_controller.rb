class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    # helper_method :current_user

    # def current_user
    #     @current_user ||= User.find(current_user.id)
    # rescue
    #     nil
    # end

  # def after_sign_in_path_for(user)
  #   # your path goes here
  #   user_posts_path(user) # as an example
  # end
end
