require 'rails_helper'

RSpec.describe "Dashboard::Orders", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/dashboard/orders/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/dashboard/orders/show"
      expect(response).to have_http_status(:success)
    end
  end

end
