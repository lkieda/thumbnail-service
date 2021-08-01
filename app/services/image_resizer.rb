class ImageResizer
  def resize(image, width, height)
    resize_arg = if width > image.width && height > image.height
                   "#{image.width}x#{image.height}"
                 else
                   "#{width}x#{height}"
                 end

    image.combine_options do |b|
      b.resize(resize_arg)
      b.background("black")
      b.gravity("center")
      b.extent("#{width}x#{height}")
    end

    image
  end
end
