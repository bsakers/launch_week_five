class Comment < ActiveRecord::Base
  belongs_to :recipe
  validates :comment, presence: true
  validates :comment, length: { maximum: 140 }
end
