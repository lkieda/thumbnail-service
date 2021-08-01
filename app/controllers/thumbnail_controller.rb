class ThumbnailController < ApplicationController
  def resize
    image = MiniMagick::Image.open(params[:url])
    width = params[:width].to_i
    height = params[:height].to_i

    resized_image = ::ImageResizer.new.resize(image, width, height)
    send_file resized_image.path, type: resized_image.mime_type, disposition: "inline"
  end
end
