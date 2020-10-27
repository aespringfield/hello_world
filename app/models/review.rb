class Review < ApplicationRecord

  belongs_to :supplier

  validates :title, presence: true
  validates :body, presence: true
  validates :rating, presence: true, numericality: {
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 5,
      only_integer: true
  }
  validates :supplier, presence: true

  scope :desc_by_rating, -> { order(rating: :desc) }

end