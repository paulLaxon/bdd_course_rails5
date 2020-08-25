# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Showing an article' do
  before do
    @john = User.create!(email: 'john@example.com', password: 'password')
    @jane = User.create!(email: 'jane@example.com', password: 'password')
    @article = Article.create(title: 'Article Title', body: 'Body of article', user: @john)
  end

  scenario 'Edit & Delete buttons hidden from non-signed in user' do
    visit '/'
    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).to have_no_link('Edit Article')
    expect(page).to have_no_link('Delete Article')
  end

  scenario 'Edit & Delete buttons shown to article owner' do
    login_as(@john)
    visit '/'

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).to have_link('Edit Article')
    expect(page).to have_link('Delete Article')
  end

  scenario 'Edit & Delete buttons hidden from non-owning user' do
    login_as(@jane)
    visit '/'

    click_link @article.title

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).to have_no_link('Edit Article')
    expect(page).to have_no_link('Delete Article')
  end
end
