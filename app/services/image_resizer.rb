class ImageResizer
  def resize(image, width, height)
    image_copy = MiniMagick::Image.open(image)

    resize_arg = if width > image_copy.width && height > image_copy.height
                   "#{image_copy.width}x#{image_copy.height}"
                 else
                   "#{width}x#{height}"
                 end

    image_copy.combine_options do |b|
      b.resize(resize_arg)
      b.background("black")
      b.gravity("center")
      b.extent("#{width}x#{height}")
    end

    image_copy
  end
end
