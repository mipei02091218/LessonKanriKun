class Lesson < ApplicationRecord
  
belongs_to :teacher, class_name: "User"
has_many :absences, dependent: :destroy
has_many :absent_students, through: :absences, source: :user

validates :start_time, presence: true

end
