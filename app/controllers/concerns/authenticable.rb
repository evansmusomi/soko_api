module Authenticable

  # Devise method override - get current user based on auth token in header
  def current_user
    @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end

  # Devise method ovveride - for authorization
  def authenticate_with_token!
    renders json: {errors: "Not authenticated"},
    status: :unauthorized unless current_user.present?
  end
end
