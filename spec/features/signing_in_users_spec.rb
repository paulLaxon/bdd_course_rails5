# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Signing in users' do
  before do
    @john = User.create!(email: 'john@example.com', password: 'password')
  end

  scenario 'with valid credentials' do
    visit '/'

    click_link 'Sign In'
    fill_in 'Email', with: @john.email
    fill_in 'Password', with: @john.password
    click_button 'Sign In'

    expect(page).to have_content('Signed in successfully')
    expect(page).to have_content("Signed in as #{@john.email}")
    expect(page).to_not have_link('Sign In')
    expect(page).to_not have_link('Sign Up')
  end
end
