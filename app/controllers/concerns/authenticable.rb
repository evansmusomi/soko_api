module Authenticable

  # Devise method override - get current user based on auth token in header
  def current_user
    @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end
end
