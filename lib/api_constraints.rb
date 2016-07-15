class ApiConstraints
  #Handle API versioning through headers
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  def matches?(req)
    @default || req.headers['Accept'].include?("application/vnd.sokoapi.v#{@version}")
  end
end
