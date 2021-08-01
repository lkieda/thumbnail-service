class ThumbnailController < ApplicationController
  def resize
    image = MiniMagick::Image.open(params[:url])

    send_file image.path, type: image.mime_type, disposition: "inline"
  end
end
