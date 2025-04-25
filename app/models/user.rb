class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥々ー]+\z/
  VALID_KANA_REGEX = /\A[ァ-ンー－]+\z/
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  VALID_EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\z/
   
  validates :name, presence: true, format: { 
    with: VALID_NAME_REGEX, 
    message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' 
  }

  validates :name_kana, presence: true, format: { 
    with: VALID_KANA_REGEX, 
    message: 'は全角カタカナで入力してください' 
  }

  validates :email, format: {
    with: VALID_EMAIL_REGEX,
    message: 'には@を含めて正しく入力してください'
  }

  validates :password, format: {
    with: PASSWORD_REGEX, 
    message: 'には英字と数字の両方を含めて設定してください'
  }, on: :create

  enum role: { student: 'student', teacher: 'teacher' }

  after_initialize :set_default_role, if: :new_record?
  before_validation :restrict_role_assignment, on: :create 

  private
       
  def set_default_role
    self.role ||= "student"
  end

  def restrict_role_assignment
    if User.count > 0
      self.role = 'student'
    end
  end

end
