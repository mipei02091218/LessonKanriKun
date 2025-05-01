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

  before_validation :assign_role_on_create, on: :create

  has_many :lessons, foreign_key: 'teacher_id', dependent: :destroy
  has_many :absences, dependent: :destroy
  has_many :absent_lessons, through: :absences, source: :lesson

  private
       
  def assign_role_on_create
    # 最初のユーザーには teacher を設定、それ以降は student を設定
    if User.count == 0
      self.role ||= 'teacher'  # 最初のユーザーだけteacher
    else
      self.role ||= 'student'  # それ以降はstudent
    end
  end

end
