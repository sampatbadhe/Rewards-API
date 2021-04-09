module ApiErrors
  class BaseError < StandardError
    attr_accessor :status

    def initialize(message, status: :unprocessable_entity)
      message = message.join('. ') if message.is_a? Array
      super(message)
      @status = status
    end

    def type
      self.class.name.split(':').last
    end

    def as_json
      { error: message, type: type, status: status }
    end
  end

  class AccessError < BaseError; end

  def define_error_klass(base, default_translation_key, **opts)
    error_klass = Class.new(base) do
      define_method(:initialize) do |key: default_translation_key, params: {}|
        message = I18n.t(key, { **params })
        super(message, **opts)
      end

      %i[with_text with_translation].each do |name|
        define_singleton_method(name) do |key, params: {}|
          translation_key = default_translation_key if key.blank?
          error_klass.new(translation_key: translation_key, params: params)
        end
      end
    end
  end

  module_function :define_error_klass

  UnauthorizedError = define_error_klass(AccessError, 'errors.unauthorized')
  NotFoundError = define_error_klass(BaseError, 'errors.not_found', status: 404)
  InvalidParamsError = define_error_klass(BaseError, 'errors.invalid_params', status: 422)
end
