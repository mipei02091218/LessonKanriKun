class CreateAbsences < ActiveRecord::Migration[7.1]
  def change
    create_table :absences do |t|
      t.references :user, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
    
    #同じ生徒が同じレッスンに複数回欠席登録できないようにする
    add_index :absences, [:user_id, :lesson_id], unique: true
  end
end
