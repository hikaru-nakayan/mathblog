class Post < ApplicationRecord
  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true
  validates :title, presence: true

  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end
  
end
