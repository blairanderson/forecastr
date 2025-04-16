module TokenAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_with_api_key
  end

  private
    def authenticate_with_api_key
      api_key = request.headers["X-API-Key"]
      return unless api_key

      if user = User.find_by(api_key: api_key)
        Current.session = Session.new(user: user)
      else
        render json: { error: "Invalid API key" }, status: :unauthorized
      end
    end
end
