class Category < ApplicationRecord
  has_many :words
  has_many :lessons

  validates :name, presence: true, length: {maximum: 50},
    uniqueness: {case_sensitive: false}
  validates :description, length: {maximum: 255}
end
