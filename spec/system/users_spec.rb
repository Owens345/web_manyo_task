require 'rails_helper'

RSpec.describe 'User Management Functions', type: :system do
  describe 'Registration function' do
    context 'When a user is registered' do
      it 'Transition to the task list screen' do
        visit new_user_path
        fill_in 'Name', with: 'New User'
        fill_in 'Email address', with: 'newuser@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password (confirmation)', with: 'password'
        click_button 'register'
        expect(page).to have_content 'Task list page'
      end
    end

    context 'When you move to the Task List screen without logging in' do
      it 'The user is redirected to the login screen and the message "Please log in" is displayed.' do
        visit tasks_path
        expect(page).to have_content 'Please log in'
        expect(page).to have_content 'Login page'
      end
    end
  end

  describe 'Login function' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:admin) { FactoryBot.create(:admin_user) }

    context 'When logged in as a registered user' do
      before do
        visit new_session_path
        fill_in 'Email address', with: user.email
        fill_in 'Password', with: 'password'
        click_button 'Login'
      end

      it 'Moves to the Task List screen and displays the message "You are logged in."' do
        expect(page).to have_content 'I have logged in'
        expect(page).to have_content 'Task list page'
      end

      it 'Access to your own detail screen.' do
        visit user_path(user)
        expect(page).to have_content 'Account details page'
      end

      it "Accessing someone else's detail screen will take you to the task list screen." do
        visit user_path(admin)
        expect(page).to have_content 'Task list page'
      end

      it 'When logging out, the user is taken to the login screen and the message "You have logged out" is displayed.' do
        click_link 'Log out'
        expect(page).to have_content 'logged out'
        expect(page).to have_content 'Login page'
      end
    end
  end

  describe 'Administrator function' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:admin) { FactoryBot.create(:admin_user) }

    before do
      visit new_session_path
      fill_in 'Email address', with: admin.email
      fill_in 'Password', with: 'password'
      click_button 'Login'
    end

    context 'When the administrator logs in' do
      it 'Access to the user list screen' do
        visit admin_users_path
        expect(page).to have_content 'User list page'
      end

      it 'Can register administrators' do
        visit new_admin_user_path
        fill_in 'Name', with: 'New Admin'
        fill_in 'Email address', with: 'newadmin@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password (confirmation)', with: 'password'
        check 'Administrator rights'
        click_button 'register'
        expect(page).to have_content 'You have registered a user'
      end

      it 'Access to user details screen' do
        visit admin_user_path(user)
        expect(page).to have_content 'User details page'
      end

      it 'Edit users other than yourself from the user edit screen' do
        visit edit_admin_user_path(user)
        fill_in 'Name', with: 'Updated Name'
        click_button 'Update'
        expect(page).to have_content 'Updated users'
      end

      it 'Users can be deleted.' do
        visit admin_users_path
        within("tr", text: user.name) do
          accept_confirm do
            click_link 'delete'
          end
        end
        expect(page).to have_content 'You have deleted a user'
      end
    end

    context 'When a general user accesses the User List screen' do
      it 'Moves to the task list screen and displays the error message "Only administrators can access this screen".' do
        # Log out from admin
        click_link 'Log out'
        # Log in as regular user
        visit new_session_path
        fill_in 'Email address', with: user.email
        fill_in 'Password', with: 'password'
        click_button 'Login'
        # Try to access admin page
        visit admin_users_path
        expect(page).to have_content 'Only administrators can access'
      end
    end
  end
end
