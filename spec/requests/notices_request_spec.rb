require 'rails_helper'

RSpec.describe "Notices", type: :request do
  let(:teacher) { create(:teacher) }
  let(:student) { create(:user) }
  let(:notice) { create(:notice, user: teacher) }
  let(:valid_params) { { notice: { content: "新しいお知らせ" } } }
  let(:invalid_params) { { notice: { content: "" } } }

  describe "先生としてログイン" do
    before { sign_in teacher }

    it "GET /notices/new は成功" do
      get new_notice_path
      expect(response).to have_http_status(:ok)
    end

    it "POST /notices は成功してリダイレクト" do
      post notices_path, params: valid_params
      expect(response).to redirect_to(root_path)
      expect(Notice.last.content).to eq("新しいお知らせ")
    end

    it "POST /notices は無効データでnew再描画" do
      post notices_path, params: invalid_params
      expect(response).to have_http_status(422)
      expect(response.body).to include("お知らせ投稿") # 画面にある文言を入れてください
    end

    it "GET /notices/:id/edit は成功" do
      get edit_notice_path(notice)
      expect(response).to have_http_status(:ok)
    end

    it "PATCH /notices/:id は成功してリダイレクト" do
      patch notice_path(notice), params: valid_params
      expect(response).to redirect_to(root_path)
      expect(notice.reload.content).to eq("新しいお知らせ")
    end

    it "PATCH /notices/:id は無効データでedit再描画" do
      patch notice_path(notice), params: invalid_params
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("編集") # 編集画面の何か文字を入れてください
    end

    it "DELETE /notices/:id は成功してリダイレクト" do
      delete notice_path(notice)
      expect(response).to redirect_to(root_path)
      expect { notice.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "生徒としてログイン" do
    before { sign_in student }

    it "GET /notices/new はリダイレクト" do
      get new_notice_path
      expect(response).to redirect_to(root_path)
    end

    it "POST /notices はリダイレクト" do
      post notices_path, params: valid_params
      expect(response).to redirect_to(root_path)
    end

    it "GET /notices/:id/edit はリダイレクト" do
      get edit_notice_path(notice)
      expect(response).to redirect_to(root_path)
    end

    it "PATCH /notices/:id はリダイレクト" do
      patch notice_path(notice), params: valid_params
      expect(response).to redirect_to(root_path)
    end

    it "DELETE /notices/:id はリダイレクト" do
      delete notice_path(notice)
      expect(response).to redirect_to(root_path)
    end
  end

  describe "未ログイン" do
    it "GET /notices/new はログイン画面へリダイレクト" do
      get new_notice_path
      expect(response).to redirect_to(new_user_session_path)
    end

    it "POST /notices はログイン画面へリダイレクト" do
      post notices_path, params: valid_params
      expect(response).to redirect_to(new_user_session_path)
    end

    it "GET /notices/:id/edit はログイン画面へリダイレクト" do
      get edit_notice_path(notice)
      expect(response).to redirect_to(new_user_session_path)
    end

    it "PATCH /notices/:id はログイン画面へリダイレクト" do
      patch notice_path(notice), params: valid_params
      expect(response).to redirect_to(new_user_session_path)
    end

    it "DELETE /notices/:id はログイン画面へリダイレクト" do
      delete notice_path(notice)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
