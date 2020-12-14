require 'rails_helper'

RSpec.describe 'Article', type: :system do
  let!(:user) { create(:user) }
  let!(:articles) { create_list(:article, 3, user: user) }
  before do
    sign_in user
  end
  
  it '記事一覧が表示できる' do
    visit root_path
    articles.each do |article|
      expect(page).to have_css('.article-content', text: article.content)
    end
  end

  it 'コメント一覧が表示される' do
    visit root_path
    first('.comment-page-link').click
    expect(page).to have_css('.add-comment')
  end

  it 'プロフィールページが表示される' do
    visit root_path
    first('.profile-page-link').click
    expect(page).to have_css('.profile')
  end

  it '記事投稿ページが表示される' do
    visit root_path
    find('.article-new').click
    expect(page).to have_css('.article-new-header-title')
  end

  it 'ユーザーページが表示される' do
    visit root_path
    first('.account-page-link').click
    expect(page).to have_css('.profile')
  end

  it '記事一覧ページが表示される' do
    visit root_path
    find('.articles-page-link').click
    expect(page).to have_css('.articles-header')
  end

  it 'タイムライン一覧ページが表示される' do
    visit root_path
    find('.timeline-page-link').click
    expect(page).to have_css('.timelines')
  end

  it '記事投稿一覧ページが表示される' do
    visit root_path
    find('.nav-article-new').click
    expect(page).to have_css('.article-new')
  end

  it 'プロフィールページが表示される' do
    visit root_path
    find('.nav-profile-page-link').click
    expect(page).to have_css('.profile')
  end

  
end