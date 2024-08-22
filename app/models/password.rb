class Password < ApplicationRecord
  encrypts :account, :pass
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true
end
