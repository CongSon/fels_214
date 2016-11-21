class User < ApplicationRecord
  has_many :lessons, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  scope :all_users, -> search {where QUERY_BY_NAME, search: "%#{search}%"}

  QUERY_BY_NAME = "name like :search"

  class << self
    def find_all_user
      User.where(is_admin: false).order created_at: :ASC
    end
  end
end
