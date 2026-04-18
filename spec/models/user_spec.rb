require 'rails_helper'

RSpec.describe 'User Model Functions', type: :model do
  describe 'Validation test' do
    context 'If the user name is an empty string' do
      it 'Validation fails' do
        user = User.new(name: '', email: 'test@example.com', password: 'password', password_confirmation: 'password')
        expect(user).not_to be_valid
      end
    end

    context 'If the user email address is an empty string' do
      it 'Validation fails' do
        user = User.new(name: 'Test', email: '', password: 'password', password_confirmation: 'password')
        expect(user).not_to be_valid
      end
    end

    context 'If the user password is an empty string' do
      it 'Validation fails' do
        user = User.new(name: 'Test', email: 'test@example.com', password: '', password_confirmation: '')
        expect(user).not_to be_valid
      end
    end

    context 'If the user email address is already in use' do
      it 'Validation fails' do
        User.create!(name: 'Existing', email: 'duplicate@example.com', password: 'password', password_confirmation: 'password')
        user = User.new(name: 'Test2', email: 'duplicate@example.com', password: 'password', password_confirmation: 'password')
        expect(user).not_to be_valid
      end
    end

    context 'If the user password is less than 6 characters' do
      it 'Validation fails' do
        user = User.new(name: 'Test', email: 'test@example.com', password: '12345', password_confirmation: '12345')
        expect(user).not_to be_valid
      end
    end

    context 'If name, unused email, and password >= 6 chars' do
      it 'Validation succeeds' do
        user = User.new(name: 'Test', email: 'test@example.com', password: 'password', password_confirmation: 'password')
        expect(user).to be_valid
      end
    end
  end
end
