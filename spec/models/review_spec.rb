require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:supplier) { Supplier.create(name: 'Supplier Name') }
  let(:subject) { described_class.new(title: 'Review title', body: 'Review Body', rating: 2, supplier_id: supplier.id) }

  it 'is valid with minimum attributes' do
    expect(subject).to be_valid
  end

  it 'is invalid without a title' do
    subject.title = nil
    aggregate_failures do
      expect(subject).to_not be_valid
      expect(subject.errors.count).to eq(1)
      expect(subject.errors.full_messages.first).to eq("Title can't be blank")
    end
  end

  it 'is invalid without a body' do
    subject.body = nil
    aggregate_failures do
      expect(subject).to_not be_valid
      expect(subject.errors.count).to eq(1)
      expect(subject.errors.full_messages.first).to eq("Body can't be blank")
    end
  end

  it 'is invalid without a rating' do
    subject.rating = nil
    aggregate_failures do
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages.first).to include("Rating can't be blank")
    end
  end

  it 'is invalid without a supplier_id' do
    subject.supplier_id = nil
    aggregate_failures do
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Supplier can't be blank")
    end
  end

  it 'is invalid with a rating below 1' do
    subject.rating = 0
    aggregate_failures do
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include("Rating must be greater than or equal to 1")
    end
  end

  it 'is invalid with a rating above 5' do
    subject.rating = 6
    aggregate_failures do
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages.first).to include("Rating must be less than or equal to 5")
    end
  end

  it 'is invalid with a non-integer rating' do
    subject.rating = 1.5
    aggregate_failures do
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages.first).to include("Rating must be an integer")
    end
  end
end
