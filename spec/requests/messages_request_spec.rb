require 'rails_helper'

RSpec.describe "Messages", type: :request do
  let(:student) { FactoryBot.create(:user) }
  let(:teacher) { FactoryBot.create(:teacher) }
  let!(:message) { FactoryBot.create(:message, sender: student, receiver: teacher) }

  describe "ログインしている生徒として" do
    before { sign_in student }

    it "GET /messages は成功" do
      get messages_path
      expect(response).to have_http_status(:success)
    end

    it "GET /messages/:id は成功し、既読に更新されない（受信者じゃないため）" do
      get message_path(message)
      expect(response).to have_http_status(:success)
      expect(message.reload.read).to eq(false)
    end

    it "GET /messages/new は成功" do
      get new_message_path
      expect(response).to have_http_status(:success)
    end

    it "POST /messages でメッセージ作成できる" do
      post messages_path, params: {
        message: { subject: "質問", body: "授業について教えてください" },
        receiver_id: teacher.id
      }
      expect(response).to redirect_to(messages_path)
    end

    it "POST /messages で失敗時は new 再描画" do
      post messages_path, params: {
        message: { subject: "", body: "" },
        receiver_id: teacher.id
      }
      expect(response).to have_http_status(422).or have_http_status(:success) # fallback
    end
  end

  describe "ログインしている先生として" do
    before { sign_in teacher }

    it "GET /messages/:id は成功し、既読に更新される" do
      get message_path(message)
      expect(response).to have_http_status(:success)
      expect(message.reload.read).to eq(true)
    end

    it "GET /messages/:id/reply は成功" do
      get reply_message_path(message)
      expect(response).to have_http_status(:success)
    end

    it "POST /messages/:id/create_reply で返信が作成できる" do
      post create_reply_message_path(message), params: {
        message: { body: "了解しました", receiver_id: student.id }
      }
      expect(response).to redirect_to(messages_path)
    end

    it "POST /messages/:id/create_reply で失敗した場合は reply 再描画" do
      post create_reply_message_path(message), params: {
        message: { body: "", receiver_id: student.id }
      }
      expect(response).to have_http_status(422).or have_http_status(:success) # fallback
    end
  end

  describe "未ログイン時" do
    it "GET /messages はログインページへリダイレクト" do
      get messages_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
