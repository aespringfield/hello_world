require 'rails_helper'

RSpec.describe SuppliersHelper, type: :helper do

  describe("#highlighted_review_excerpt") do

    it 'returns nil if there are no reviews' do
      supplier = Supplier.new(name: 'Fake Supplier')
      expect(helper.highlighted_review_excerpt(supplier)).to be(nil)
    end

    it 'returns a full review body if it is less than or equal to 150 characters' do
      supplier = Supplier.create(name: 'Fake Supplier')
      supplier.reviews.create(
        title: 'A review',
        body: 'a' * 150,
        rating: '3'
      )
      expect(helper.highlighted_review_excerpt(supplier)).to eq("\"#{'a' * 150}\"")
    end

    it 'returns a truncated review if it is more than 150 characters' do
      supplier = Supplier.create(name: 'Fake Supplier')
      supplier.reviews.create(
          title: 'A review',
          body: 'a' * 151,
          rating: '3'
      )
      expect(helper.highlighted_review_excerpt(supplier)).to eq("\"#{'a' * 146}... \"")
    end
  end
end
