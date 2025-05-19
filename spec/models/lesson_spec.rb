require 'rails_helper'

RSpec.describe Lesson, type: :model do
  describe 'バリデーションのテスト' do
    let(:lesson) {build(:lesson)}

    it '有効なデータなら保存できる' do
      expect(lesson).to be_valid
    end

    it 'start_timeがないと保存できない' do
      lesson.start_time = nil
      expect(lesson).to_not be_valid
      expect(lesson.errors.full_messages).to include("Start time can't be blank")
    end
  end
end
