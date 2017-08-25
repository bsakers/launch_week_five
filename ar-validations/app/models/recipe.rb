class Recipe < ActiveRecord::Base
  has_many :comments
  validates :title, presence: true
  validates :title, uniqueness: true
  validates :title, format: {with: /brussels sprouts/}
  validates :servings,
    allow_nil: true,
    numericality: {greater_than_or_equal_to: 1}
end
