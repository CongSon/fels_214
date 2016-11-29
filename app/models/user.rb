class User < ApplicationRecord
  has_many :lessons, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :activities, as: :activityable

  scope :all_users, -> search {where QUERY_BY_NAME_OR_EMAIL, search: "%#{search}%"}

  QUERY_BY_NAME_OR_EMAIL = "name like :search or email like :search"

  attr_accessor :remember_token
  before_save { email.downcase! }
    validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX },
    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true
  mount_uploader :avatar, PictureUploader
  validate  :avatar_size

  class << self
    def find_all_user
      User.select(:id, :name, :email, :avatar).where(is_admin: false).order created_at: :ASC
    end

    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attributes remember_digest: nil
  end

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following? other_user
    following.include? other_user
  end

  private
  def avatar_size
    if avatar.size > 5.megabytes
      errors.add(:avatar, t("should_be_less_than_5MB"))
    end
  end
end
