require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:sender) { FactoryBot.create(:user) }
  let(:receiver) { FactoryBot.create(:teacher) }

  it 'subjectとbodyがあれば有効' do
    message = Message.new(sender:, receiver:, subject: "こんにちは", body: "よろしくお願いします")
    expect(message).to be_valid
  end
  
  it 'subjectがないと無効' do
    message = Message.new(sender:, receiver:, subject: nil, body: "本文")
    expect(message).not_to be_valid
    expect(message.errors.full_messages).to include("Subject can't be blank")
  end
  
  it 'bodyがいないと無効' do
    message = Message.new(sender:, receiver:, subject: "件名", body: nil)
    expect(message).not_to be_valid
    expect(message.errors.full_messages).to include("Body can't be blank")
  end
end
