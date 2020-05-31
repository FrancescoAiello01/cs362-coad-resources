require 'rails_helper'

RSpec.describe 'User registration', type: :feature do

  context 'user registers' do

    it 'should register successfully' do
      visit signup_path
      fill_in 'user_email', with: 'fake@fake.com'
      fill_in 'user_password', with: 'fake12345678'
      fill_in 'user_password_confirmation', with: 'fake12345678'
      click_on 'commit'
      user = User.find_by(email: 'fake@fake.com')
      visit user_confirmation_path(confirmation_token: user.confirmation_token)
      expect(page).to have_text('Your email address has been successfully confirmed.')
    end

    it 'should not register successfully with a password that is too short' do
      visit signup_path
      fill_in 'user_email', with: 'fake@fake.com'
      fill_in 'user_password', with: 'fake1'
      fill_in 'user_password_confirmation', with: 'fake1'
      click_on 'commit'
      expect(page).to have_text('Password is too short')
    end

    it 'should not register successfully with an invalid email' do
      visit signup_path
      fill_in 'user_email', with: 'fake'
      fill_in 'user_password', with: 'fake12'
      fill_in 'user_password_confirmation', with: 'fake12'
      click_on 'commit'
      expect(page).to have_text('Email is invalid')
    end

  end

end
