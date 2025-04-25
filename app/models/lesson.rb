class Lesson < ApplicationRecord
  
belongs_to :teacher, class_name: "User"
#has_many :absences

validates :start_time, presence: true

end
