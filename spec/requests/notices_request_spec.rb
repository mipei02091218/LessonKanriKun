require 'rails_helper'

RSpec.describe "Notices", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/notices/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/notices/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/notices/create"
      expect(response).to have_http_status(:success)
    end
  end

end
