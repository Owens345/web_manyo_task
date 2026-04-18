require 'rails_helper'

RSpec.describe 'Label management function', type: :system do
  let!(:user) { FactoryBot.create(:user) }

  before do
    visit new_session_path
    fill_in 'Email address', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Login'
  end

  describe 'Registration function' do
    context 'When a label is registered' do
      it 'Registered labels are displayed.' do
        visit new_label_path
        fill_in 'Name', with: 'My Label'
        click_button 'register'
        expect(page).to have_content 'My Label'
      end
    end
  end

  describe 'List display function' do
    context 'When transitioning to the list screen' do
      it 'A list of registered labels is displayed.' do
        FactoryBot.create(:label, name: 'Work Label', user: user)
        visit labels_path
        expect(page).to have_content 'Work Label'
      end
    end
  end
end
