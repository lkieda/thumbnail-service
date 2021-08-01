class ParamsValidator
  def validate(params)
    errors = []

    if params.key?(:url)
      errors << "'url' is invalid" unless url_valid?(params[:url])
    else
      errors << "Parameter 'url' is required"
    end

    if params.key?(:width)
      errors << "'width' is invalid" unless params[:width].to_i > 0
    else
      errors << "Parameter 'width' is required"
    end

    if params.key?(:height)
      errors << "'height' is invalid" unless params[:height].to_i > 0
    else
      errors << "Parameter 'height' is required"
    end

    errors
  end

  private

  def url_valid?(url)
    url = URI.parse(url) rescue false
    url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
  end
end
