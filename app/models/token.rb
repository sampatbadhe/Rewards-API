# frozen_string_literal: true

# A class to handle JWT token encode/decode/verification
class Token
  attr_reader :jwt_config

  def initialize
    @jwt_config = options[:jwt_config] || Rails.application.secrets.jwt
    @bearer = options[:bearer] || ''
  end

  def generate_token(params, metadata: {})
    generate(params, metadata: metadata)
  end

  private

  def generate(params, metadata: {})
    current_time = Time.current.to_i
    payload = params.merge('iat': current_time,
                           'iss': issuer,
                           'exp': current_time + validity)

    payload = payload.merge(metadata)
    JWT.encode(payload.stringify_keys, secret_key, algorithm)
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
