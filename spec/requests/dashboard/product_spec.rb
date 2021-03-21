require 'rails_helper'

RSpec.describe "Dashboard::Products", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/dashboard/product/index"
      expect(response).to have_http_status(:success)
    end
  end

end
