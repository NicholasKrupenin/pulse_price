require 'rails_helper'

RSpec.feature 'The user can work with the pages' do

  describe 'user create page' do

    background { visit pages_path }

    scenario 'use valid data' do

      fill_in 'Name', with: 'A'
      fill_in 'Title', with: 'B'
      fill_in 'Content', with: 'Hi'
      click_on 'Create Page'

      expect(page).to have_content 'A'
    end

    scenario 'use invalid data' do

      fill_in 'Name', with: '$%^'
      fill_in 'Title', with: 'B'
      fill_in 'Content', with: 'Hi'
      click_on 'Create Page'

      expect(page).to have_content 'Name is invalid'
    end
  end

  describe 'user edit page' do
    given!(:sample_page) { create(:page) }
    background { visit "/#{sample_page.name}/edit" }

    scenario 'use valid data' do
      fill_in 'Title', with: 'B'
      fill_in 'Content', with: 'Hi'
      click_on 'Update Page'

      expect(page).to have_content 'B'
    end

    scenario 'use invalid data' do

      fill_in 'Title', with: ''
      fill_in 'Content', with: 'Hi'
      click_on 'Update Page'

      expect(page).to have_content 'Title can\'t be blank'
    end
  end
end
