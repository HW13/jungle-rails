class Review < ActiveRecord::Base
  validates :product, presence: true
  validates :user, presence: true
  validates :rating, presence: true
  belongs_to :product
  belongs_to :user
end
