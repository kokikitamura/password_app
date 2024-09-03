class Password < ApplicationRecord
  encrypts :account, :pass
  belongs_to :user
  belongs_to :category, optional: true
  #default_scope -> { order(created_at: :desc) }
  scope :created_latest, -> {order(created_at: :desc)}
  scope :created_old, -> {order(created_at: :asc)}
  scope :updated_latest, -> {order(updated_at: :desc)}
  scope :updated_old, -> {order(updated_at: :asc)}
  validates :user_id, presence: true
  validates :title, presence: true

  # 検索
  def self.search_for(word)
    Password.where("title LIKE?", "%#{word}%")
  end

end
