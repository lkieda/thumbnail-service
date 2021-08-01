require 'rails_helper'

RSpec.describe ::ImageResizer do
  subject(:resized_image) { described_class.new.resize(source_image, target_width, target_height) }

  let(:source_image) { image_path('books.jpg') }
  let(:image_width) { 504 }
  let(:image_height) { 378 }

  context 'when target dimensions are the same as original' do
    let(:target_width) { image_width }
    let(:target_height) { image_height }

    let(:expected_image) { image_path('books_same_size.jpg') }

    it 'creates correct image' do
      expect(file_md5(resized_image.path)).to eq(file_md5(expected_image))
    end
  end

  context 'when target dimensions are smaller but aspect ratio is similar' do
    let(:target_width) { image_width / 2 }
    let(:target_height) { image_height / 2 }

    let(:expected_image) { image_path('books_half_size.jpg') }

    it 'creates scales down the image' do
      expect(file_md5(resized_image.path)).to eq(file_md5(expected_image))
    end
  end

  context 'when target dimensions are greater than original' do
    let(:target_width) { image_width * 1.5 }
    let(:target_height) { image_height * 2 }

    let(:expected_image) { image_path('books_both_paddings.jpg') }

    it 'adds all paddings to the original image' do
      expect(file_md5(resized_image.path)).to eq(file_md5(expected_image))
    end
  end

  context 'when target height is smaller than original' do
    let(:target_width) { image_width }
    let(:target_height) { image_height - 100 }

    let(:expected_image) { image_path('books_padding_left_right.jpg') }

    it 'adds left and right padding to the original image' do
      expect(file_md5(resized_image.path)).to eq(file_md5(expected_image))
    end
  end

  context 'when target height is smaller than original' do
    let(:target_width) { image_width - 100 }
    let(:target_height) { image_height }

    let(:expected_image) { image_path('books_padding_top_bottom.jpg') }

    it 'adds top and bottom padding to the original image' do
      expect(file_md5(resized_image.path)).to eq(file_md5(expected_image))
    end
  end

  def image_path(image_name)
    Rails.root.join('spec', 'support', 'images', image_name)
  end

  def file_md5(path)
    Digest::MD5.hexdigest(File.read(path.to_s))
  end
end
