require 'rails_helper'

RSpec.describe 'Label Model Function', type: :model do
  describe 'Validation test' do
    context 'If the label name is an empty string' do
      it 'Validation fails' do
        user = FactoryBot.create(:user)
        label = Label.new(name: '', user: user)
        expect(label).not_to be_valid
      end
    end

    context 'If the label name has a value' do
      it 'Validation succeeds' do
        user = FactoryBot.create(:user)
        label = Label.new(name: 'Test Label', user: user)
        expect(label).to be_valid
      end
    end
  end
end
