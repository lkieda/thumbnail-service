class ThumbnailController < ApplicationController
  def resize
    errors = ::ParamsValidator.new.validate(permitted_params)

    return render :json => { errors: errors }, :status => :bad_request if errors.any?

    url = permitted_params[:url]
    width = permitted_params[:width].to_i
    height = permitted_params[:height].to_i

    image = MiniMagick::Image.open(url)
    resized_image = ::ImageResizer.new.resize(image.path, width, height)

    send_file resized_image.path, type: resized_image.mime_type, disposition: "inline"
  rescue MiniMagick::Invalid => e
    Rails.logger.error [e.message, *e.backtrace].join($/)
    render :json => { errors: ["Invalid image"] }, :status => :bad_request
  rescue StandardError => e
    Rails.logger.error [e.message, *e.backtrace].join($/)
    render :json => { errors: ["Internal server error"] }, :status => :internal_server_error
  end

  private

  def permitted_params
    params.permit(:url, :width, :height)
  end
end
