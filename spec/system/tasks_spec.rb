require 'rails_helper'

RSpec.describe 'Task management function', type: :system do
  let!(:user) { FactoryBot.create(:user) }

  before do
    visit new_session_path
    fill_in 'Email address', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Login'
  end

  describe 'Registration function' do
    context 'When registering a task' do
      it 'The registered task is displayed' do
        visit new_task_path
        fill_in 'Title', with: 'Document preparation'
        fill_in 'Contents', with: 'Create a proposal.'
        find('#task_deadline_on').set('2022-02-18')
        select 'medium', from: 'Priority'
        select 'Not Started', from: 'Status'
        click_button 'register'
        expect(page).to have_content 'Document preparation'
      end
    end
  end

  describe 'List display function' do
    let!(:first_task)  { FactoryBot.create(:task,        title: 'first_task',  deadline_on: '2022-02-18', priority: :medium, status: :not_started,  user: user) }
    let!(:second_task) { FactoryBot.create(:second_task, title: 'second_task', deadline_on: '2022-02-17', priority: :high,   status: :in_progress, user: user) }
    let!(:third_task)  { FactoryBot.create(:third_task,  title: 'third_task',  deadline_on: '2022-02-16', priority: :low,    status: :completed,   user: user) }

    before do
      visit tasks_path
    end

    context 'When transitioning to the list screen' do
      it 'The list of created tasks is displayed in descending order of creation date and time.' do
        task_list = all('tbody tr')
        expect(task_list.first).to have_content 'third_task'
        expect(task_list.last).to have_content 'first_task'
      end
    end

    context 'When creating a new task' do
      it 'New task is displayed at the top' do
        new_task = FactoryBot.create(:task, title: 'newest_task', deadline_on: '2022-02-19', user: user)
        visit tasks_path
        task_list = all('tbody tr')
        expect(task_list.first).to have_content 'newest_task'
      end
    end

    describe 'sort function' do
      context 'If you click on the link "End date"' do
        it 'A list of tasks sorted in ascending order of due date is displayed.' do
          click_link 'End date'
          task_list = all('tbody tr')
          expect(task_list.first).to have_content 'third_task'
          expect(task_list.last).to have_content 'first_task'
        end
      end

      context 'If you click on the link "Priority"' do
        it 'A list of tasks sorted by priority is displayed' do
          click_link 'Priority'
          expect(page).to have_css('tbody tr')
          task_list = all('tbody tr')
          expect(task_list.first).to have_content 'second_task'
          expect(task_list.last).to have_content 'third_task'
        end
      end
    end

    describe 'Search function' do
      context 'If you do a fuzzy search by Title' do
        it 'Only tasks containing the search word will be displayed.' do
          fill_in 'Title', with: 'first'
          click_button 'Search'
          expect(page).to have_content 'first_task'
          expect(page).not_to have_content 'second_task'
          expect(page).not_to have_content 'third_task'
        end
      end

      context 'Search by status' do
        it 'Only tasks matching the searched status will be displayed' do
          select 'Not Started', from: 'Status'
          click_button 'Search'
          expect(page).to have_content 'first_task'
          expect(page).not_to have_content 'second_task'
          expect(page).not_to have_content 'third_task'
        end
      end

      context 'Title and search by status' do
        it 'Only tasks that contain the search word Title and match the status will be displayed' do
          fill_in 'Title', with: 'second'
          select 'In Progress', from: 'Status'
          click_button 'Search'
          expect(page).to have_content 'second_task'
          expect(page).not_to have_content 'first_task'
          expect(page).not_to have_content 'third_task'
        end
      end
    end
  end

  describe 'Detailed display function' do
    context 'When transitioned to any task details screen' do
      it 'The content of the task is displayed' do
        task = FactoryBot.create(:task, user: user)
        visit task_path(task)
        expect(page).to have_content 'Document preparation'
        expect(page).to have_content 'Create a proposal.'
      end
    end
  end
end