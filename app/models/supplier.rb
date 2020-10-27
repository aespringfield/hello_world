class Supplier < ApplicationRecord

  has_many :reviews
  validates :name, presence: true

  def random_median_review
    return if descending_ordered_reviews.empty?

    descending_ordered_reviews.select { |review|
      review.rating == median_rating
    }.sample
  end

  private

  def median_rating
    return if descending_ordered_reviews.empty?

    median_index = (descending_ordered_reviews.length / 2.0 ).ceil - 1
    descending_ordered_reviews[median_index].rating
  end

  def descending_ordered_reviews
    @descending_ordered_reviews ||= reviews.desc_by_rating
  end
end
