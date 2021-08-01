require 'rails_helper'

RSpec.describe "thumbnails endpoint", type: :request do
  describe "GET /thumbnail" do
    it 'returns resized image' do
      VCR.use_cassette("placekitten", :preserve_exact_body_bytes => true) do
        url = 'https://placekitten.com/200/300'

        get "/thumbnail", :params => { :url => url, :width => "200", :height => "300" }

        expect(response).to have_http_status(:success)
        expect(response.media_type).to eq('image/jpeg')

        expected_file = Rails.root.join('spec', 'support', 'images', 'kitten.jpg')
        expected_md5 = Digest::MD5.hexdigest(File.read(expected_file))
        actual_md5 = Digest::MD5.hexdigest(response.body)

        expect(expected_md5).to eq(actual_md5)
      end
    end
  end
end
