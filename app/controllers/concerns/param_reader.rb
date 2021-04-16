module ParamReader
  extend ActiveSupport::Concern

  # This is to parse any boolean parameters passed
  # Example: Suppose the params is as follows
  # params = {
  #   'is_allowed': 'false'
  # }
  # bool_param('is_allowed') will return false instead of 'false'
  def bool_param(key, default_value = false)
    return default_value unless params.include?(key)

    params[key].to_s == 'true'
  end

  def array_param(key)
    params.fetch(key, '').strip.split(',')
  end
end
