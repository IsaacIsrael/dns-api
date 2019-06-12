require 'rails_helper'

RSpec.describe "ApiV1Dns", type: :request do
  describe "GET /api_v1_dns" do
    it "works! (now write some real specs)" do
      get api_v1_dns_index_path
      expect(response).to have_http_status(200)
    end
  end
end
