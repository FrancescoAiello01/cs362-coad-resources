require 'rails_helper'

RSpec.describe 'Logging in', type: :feature do

  let(:user) { create(:user) }

  before :each do
    user.confirm
  end

  context 'user logs in' do

    it 'should log in successfully' do
      visit login_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_on 'Sign in'
      expect(page).to have_text('Signed in successfully.')
    end

    it 'should not log in successfully' do
      visit login_path
      fill_in 'user_email', with: 'fake'
      fill_in 'user_password', with: 'fake'
      click_on 'Sign in'
      expect(page).to have_text('Invalid Email or password.')
    end

  end

end
