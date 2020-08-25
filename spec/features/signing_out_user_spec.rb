# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Signing out users' do
  before do
    @john = User.create!(email: 'john@example.com', password: 'password')

    visit '/'
    click_link 'Sign In'

    fill_in 'Email', with: @john.email
    fill_in 'Password', with: @john.password

    click_button 'Sign In'
  end

  scenario 'sign out the user' do
    visit '/'
    click_link 'Sign Out'
    expect(page).to have_content('Signed out successfully')
    expect(page).to have_no_link('Sign Out')
  end
end
