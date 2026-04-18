require 'rails_helper'

RSpec.describe 'Task model function', type: :model do
  describe 'Validation test' do
    context 'If the task Title is an empty string' do
      it 'Validation fails' do
        task = Task.new(title: '', content: 'Create a proposal.', deadline_on: '2022-02-18', priority: :medium, status: :not_started)
        expect(task).not_to be_valid
      end
    end

    context 'If the task description is empty' do
      it 'Validation fails' do
        task = Task.new(title: 'Test title', content: '', deadline_on: '2022-02-18', priority: :medium, status: :not_started)
        expect(task).not_to be_valid
      end
    end

    context 'If the task Title and description have values' do
      it 'You can register a task' do
        task = Task.new(title: 'Test title', content: 'Create a proposal.', deadline_on: '2022-02-18', priority: :medium, status: :not_started)
        expect(task).to be_valid
      end
    end
  end

  describe 'Search function' do
    let!(:first_task)  { FactoryBot.create(:task,        title: 'first_task_title',  deadline_on: '2022-02-18', priority: :medium, status: :not_started) }
    let!(:second_task) { FactoryBot.create(:second_task, title: 'second_task_title', deadline_on: '2022-02-17', priority: :high,   status: :in_progress) }
    let!(:third_task)  { FactoryBot.create(:third_task,  title: 'third_task_title',  deadline_on: '2022-02-16', priority: :low,    status: :completed) }

    context 'Title is performed by scope method' do
      it 'Tasks containing search words are narrowed down.' do
        expect(Task.search_title('first')).to include(first_task)
        expect(Task.search_title('first')).not_to include(second_task)
        expect(Task.search_title('first')).not_to include(third_task)
        expect(Task.search_title('first').count).to eq 1
      end
    end

    context 'When the status is searched with the scope method' do
      it 'Tasks that exactly match the status are narrowed down' do
        expect(Task.search_status('not_started')).to include(first_task)
        expect(Task.search_status('not_started')).not_to include(second_task)
        expect(Task.search_status('not_started')).not_to include(third_task)
        expect(Task.search_status('not_started').count).to eq 1
      end
    end

    context 'When performing fuzzy search and status search Title' do
      it 'Refine your search to tasks that contain the search word Title and match the status exactly.' do
        result = Task.search_title('second').search_status('in_progress')
        expect(result).to include(second_task)
        expect(result).not_to include(first_task)
        expect(result).not_to include(third_task)
        expect(result.count).to eq 1
      end
    end
  end
end
