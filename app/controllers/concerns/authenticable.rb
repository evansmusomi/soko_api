module Authenticable

  # Override Devise method - Gets current user based on auth token in header
  def current_user
    @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end

  # Overide Devise method - Handles access to actions
  def authenticate_with_token!
    renders json: {errors: "Not authenticated"},
    status: :unauthorized unless user_signed_in?
  end

  # Overide Devise method - Checks user is signed in
  def user_signed_in?
    current_user.present?
  end
end
