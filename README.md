
# テーブル設計

## usersテーブル

| Colum              | Type   | Options                   |
|--------------------|--------|---------------------------|
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| email              | string | null: false               |
| encrypted_password | string | null: false, unique: true |
| role               | string | null: false               |

### Association

has_many :lessons, foreign_key: :teacher_id
has_many :absences  
has_many :notices  
has_many :posts

## absencesテーブル

| Colum        | Type        | Options                        |
|--------------|-------------|--------------------------------|
| student      | references  | null: false, foreign_key: true |
| lesson       | references  | null: false, foreign_key: true |
| absent       | boolean     | null: false                    |

### Association

belongs_to :student, class_name: "User"  
belongs_to: lesson

## lessonsテーブル

| Colum      | Type       | Options                        |
|------------|------------|--------------------------------|
| user       | references | null: false, foreign_key: true |
| start_time | datetime   | null: false                    |

### Association

belongs_to :teacher, class_name: "User"
has_many :absences

## noticesテーブル

| Colum        | Type       | Options                        |
|--------------|------------|--------------------------------|
| teacher_id   | references | null: false, foreign_key: true |
| title        | string     | null: false                    |
| body         | text       | null: false                    |
| posted_at    | datetime   | null: false                    |

### Association

belongs_to :teacher, class_name: "User", foreign_key: :teacher_id  

## postsテーブル

| Colum     | Type       | Options                        |
|-----------|------------|--------------------------------|
| user      | references | null: false, foreign_key: true |
| body      | text       | null: false                    |
| posted_at | datetime   | null: false                    |

### Association

belongs_to :user