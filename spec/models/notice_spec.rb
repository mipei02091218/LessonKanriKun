require 'rails_helper'

RSpec.describe Notice, type: :model do
  let(:user) { FactoryBot.create(:teacher) }

  it 'contentが空だと無効' do
    notice = Notice.new(user: user, content: '')
    expect(notice).not_to be_valid
    expect(notice.errors.full_messages).to include("Content can't be blank")
  end
end
