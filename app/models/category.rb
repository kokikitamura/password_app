class Category < ApplicationRecord
  belongs_to :user
  has_many :passwords
  validates :user_id, presence: true
  validates :name, presence: true
  default_scope -> { order(created_at: :desc) }
end
