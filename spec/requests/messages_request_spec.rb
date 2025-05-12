require 'rails_helper'

RSpec.describe "Messages", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/messages/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/messages/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/messages/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/messages/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /reply" do
    it "returns http success" do
      get "/messages/reply"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update_reply" do
    it "returns http success" do
      get "/messages/update_reply"
      expect(response).to have_http_status(:success)
    end
  end

end
