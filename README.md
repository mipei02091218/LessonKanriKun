
# テーブル設計

## usersテーブル

| Colum              | Type   | Options                   |
|--------------------|--------|---------------------------|
| name               | string | null: false               |
| name_kana          | string | null: false               |
| email              | string | null: false               |
| encrypted_password | string | null: false, unique: true |
| role               | string | null: false               |

### Association

has_many :lessons, foreign_key: :teacher_id
has_many :absences
has_many :absent_lessons  
has_many :notices  
has_many :posts

## absencesテーブル

| Colum  | Type        | Options                        |
|--------|-------------|--------------------------------|
| user   | references  | null: false, foreign_key: true |
| lesson | references  | null: false, foreign_key: true |

### Association

belongs_to :user  
belongs_to: lesson

## lessonsテーブル

| Colum      | Type       | Options                        |
|------------|------------|--------------------------------|
| user       | references | null: false, foreign_key: true |
| start_time | datetime   | null: false                    |

### Association

belongs_to :teacher, class_name: "User"
has_many :absences
has_many :absent_students

## noticesテーブル

| Colum      | Type       | Options                        |
|------------|------------|--------------------------------|
| user       | references | null: false, foreign_key: true |
| content    | text       | null: false                    |

### Association

belongs_to :user 

## postsテーブル

| Colum     | Type       | Options                        |
|-----------|------------|--------------------------------|
| user      | references | null: false, foreign_key: true |
| content   | text       | null: false                    |

### Association

belongs_to :user