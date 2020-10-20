require 'rails_helper'

RSpec.feature 'Basic Usage', type: :feature do
  it 'can do happy path' do
    visit suppliers_path

    click_link_or_button('Add Supplier')

    expect(page).to have_content('Create a Supplier')

    fill_in 'supplier[name]', with: 'Hooli'
    fill_in 'supplier[ein]', with: '98-7654321'
    fill_in 'supplier[address_1]', with: '1 Infinite Loop'
    fill_in 'supplier[address_2]', with: '10th floor'
    fill_in 'supplier[city]', with: 'Mountain View'
    fill_in 'supplier[state]', with: 'CA'
    fill_in 'supplier[phone_number]', with: '111-123-4567'

    click_link_or_button('Create')

    expect(page).to have_current_path(supplier_path(Supplier.last))

    aggregate_failures do
      expect(page).to have_content('Hooli')
      expect(page).to have_content('98-7654321')
      expect(page).to have_content('1 Infinite Loop')
      expect(page).to have_content('10th floor')
      expect(page).to have_content('Mountain View')
      expect(page).to have_content('CA')
      expect(page).to have_content('111-123-4567')
    end

    click_link_or_button('Back to Suppliers')

    expect(page).to have_content('Hooli')

    click_link_or_button('Add Supplier')

    fill_in 'supplier[name]', with: 'Dunder Mifflin'
    fill_in 'supplier[ein]', with: '12-3456789'
    fill_in 'supplier[address_1]', with: '100 Paper Way'
    fill_in 'supplier[address_2]', with: 'Suite 200'
    fill_in 'supplier[city]', with: 'Scranton'
    fill_in 'supplier[state]', with: 'PA'
    fill_in 'supplier[phone_number]', with: '222-333-9876'

    click_link_or_button('Create')

    expect(page).to have_current_path(supplier_path(Supplier.last))
    aggregate_failures do
      expect(page).to have_content('Dunder Mifflin')
      expect(page).to have_content('12-3456789')
      expect(page).to have_content('100 Paper Way')
      expect(page).to have_content('Suite 200')
      expect(page).to have_content('Scranton')
      expect(page).to have_content('PA')
      expect(page).to have_content('222-333-9876')
    end

    click_link_or_button('Write a Review')

    fill_in 'review[title]', with: "An interesting experience"
    fill_in 'review[body]', with: 'My team was all right. They had some odd comments about the Syracuse branch, though...'
    select '4', from: 'review[overall_rating]'

    click_link_or_button('Publish')

    aggregate_failures do
      expect(page).to have_content('An interesting experience')
      expect(page).to have_content('My team was all right. They had some odd comments about the Syracuse branch, though...')
      expect(page).to have_content('Overall Rating: 4')
    end

    click_link_or_button('Back to Suppliers')

    aggregate_failures do
      expect(page).to have_content('Hooli')
      expect(page).to have_content('Dunder Mifflin')
    end
  end
end
