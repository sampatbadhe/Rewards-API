module TokenValidatable
  extend ActiveSupport::Concern

  included do
    before_action :validate_token
  end

  def generate_token(options={})
    Token.new.generate_token(options)
  end

  private

  def validate_token
    unless token.valid?
      raise ApiErrors::UnauthorizedError.with_text(token.errors.full_messages.join)
    end
  end

  def token
    @token ||= Token.new(bearer: request.headers['Authorization'])
  end
end
