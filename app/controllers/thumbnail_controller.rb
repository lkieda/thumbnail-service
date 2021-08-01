class ThumbnailController < ApplicationController
  def resize
    errors = validate_parameters

    return render :json => { errors: errors }, :status => :bad_request if errors.any?

    url = permitted_params[:url]
    width = permitted_params[:width].to_i
    height = permitted_params[:height].to_i

    image = MiniMagick::Image.open(url)
    resized_image = ::ImageResizer.new.resize(image, width, height)

    send_file resized_image.path, type: resized_image.mime_type, disposition: "inline"
  rescue MiniMagick::Invalid => _e
    render :json => { errors: ["Invalid image"] }, :status => :bad_request
  rescue StandardError => _e
    render :json => { errors: ["Internal server error"] }, :status => :internal_server_error
  end

  private

  def permitted_params
    params.permit(:url, :width, :height)
  end

  def validate_parameters
    errors = []

    if permitted_params.key?(:url)
      errors << "'url' is invalid" unless url_valid?(permitted_params[:url])
    else
      errors << "Parameter 'url' is required"
    end

    if permitted_params.key?(:width)
      errors << "'width' is invalid" unless permitted_params[:width].to_i > 0
    else
      errors << "Parameter 'width' is required"
    end

    if permitted_params.key?(:height)
      errors << "'height' is invalid" unless permitted_params[:width].to_i > 0
    else
      errors << "Parameter 'height' is required"
    end

    errors
  end

  def url_valid?(url)
    url = URI.parse(url) rescue false
    url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
  end
end
