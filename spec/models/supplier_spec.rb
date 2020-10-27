require 'rails_helper'

RSpec.describe Supplier, type: :model do

  it 'is valid with minimum attributes' do
    supplier = Supplier.new(name: 'Supplier Name')
    expect(supplier).to be_valid
  end

  it 'is invalid without a name' do
    supplier = Supplier.new(address_1: '100 Main St', city: 'Washington', state: 'DC')
    supplier.valid?
    aggregate_failures do
      expect(supplier).to_not be_valid
      expect(supplier.errors.count).to eq(1)
      expect(supplier.errors.full_messages.first).to eq("Name can't be blank")
    end
  end

  describe '#random_median_review' do

    it 'returns nil if there are no reviews' do
      supplier = Supplier.new(name: 'Fake Supplier')
      expect(supplier.random_median_review).to be(nil)
    end

    it 'returns a review with the expected rating when number of reviews is even' do
      supplier = Supplier.create(name: 'Fake Supplier')

      [ 1, 1, 1, 2, 2, 5 ].each_with_index do |rating, i|
        supplier.reviews.create(
          title: 'Some title',
          body: "Rater #{i} gave this a #{rating}",
          rating: rating
        )
      end

      random_median_review = supplier.random_median_review
      expect(random_median_review.rating).to eq(2)

      possible_review_bodies = ["Rater 3 gave this a 2", "Rater 4 gave this a 2"]
      expect(possible_review_bodies).to include(random_median_review.body)
    end

    it 'returns a review with the expected rating when number of reviews is odd' do
      supplier = Supplier.create(name: 'Fake Supplier')

      [ 1, 1, 1, 2, 2 ].each_with_index do |rating, i|
        supplier.reviews.create(
            title: 'Some title',
            body: "Rater #{i} gave this a #{rating}",
            rating: rating
        )
      end

      random_median_review = supplier.random_median_review
      expect(random_median_review.rating).to eq(1)

      possible_review_bodies = ["Rater 0 gave this a 1", "Rater 1 gave this a 1", "Rater 2 gave this a 1"]
      expect(possible_review_bodies).to include(random_median_review.body)
    end

  end
end
