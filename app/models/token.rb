# frozen_string_literal: true

# A class to handle JWT token encode/decode/verification
#
# Initialize token with request header e.g. Token.new( bearer: request.headers['Authorization'] )
# Call token.valid? and token.errors

class Token
  include ::ActiveModel::Validations
  attr_reader :jwt_config

  validate :token_validation

  #
  # Token class initializer
  #
  # @param [Hash] options
  # @option options [String] :bearer The bearer token to parse
  # @option options [Hash] :jwt_config The JWT options (secret, algo, ...)
  #
  def initialize(options = {})
    @jwt_config = options[:jwt_config] || Rails.application.credentials.jwt
    @bearer = options[:bearer] || ''
  end

  def generate_token(params, metadata: {})
    generate(params, metadata: metadata)
  end

  def read(key, default: nil)
    data[0][key] || default
  end

  def data
    token if jwt_string.present?
  end

  private

  # Generate an encoded Json Web Token to send to client app
  # as part of the authentication/authorization process
  # Additional options can be encoded inside the token
  # params = { 'user_id': 123 }
  def generate(params, metadata: {})
    current_time = Time.current.to_i
    payload = params.merge('iat': current_time,
                           'iss': issuer,
                           'exp': current_time + validity)

    payload = payload.merge(metadata)
    JWT.encode(payload.stringify_keys, secret_key, algorithm)
  end

  # Is the JWT token authentic?
  # exp should be in the future
  # iat should be in the past
  def token_validation
    return errors.add(:base, I18n.t('token.invalid')) if jwt_string.blank? || token.all?(&:blank?)

    current_time = Time.current
    iat_time = Time.at(read('iat'))
    exp_time = Time.at(read('exp'))
    if exp_time < current_time
      errors.add(:base, I18n.t('token.expired'))
    elsif iat_time >= current_time && iat_time > exp_time
      errors.add(:base, I18n.t('token.invalid'))
    end
  rescue JWT::DecodeError
    errors.add(:base, I18n.t('token.invalid'))
  end

  def jwt_string
    @jwt_string ||= @bearer.sub('Bearer ', '')
  end

  def token
    @token ||= JWT.decode(jwt_string, secret_key, true, algorithm: algorithm)
  end

  def issuer
    jwt_config[:issuer]
  end

  def validity
    jwt_config[:validity]
  end

  def secret_key
    jwt_config[:secret_key]
  end

  def algorithm
    jwt_config[:algorithm]
  end
end
