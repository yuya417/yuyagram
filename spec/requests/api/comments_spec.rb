require 'rails_helper'

RSpec.describe 'Api::Comments', type: :request do
  let!(:user) { create(:user)}
  let!(:article) { create(:article, user: user, profile_id: user.id) }
  let!(:comments) { create_list(:comment, 3, article: article, user: user) }
  
  
  describe 'GET /api/comments' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it '200 Status' do
        get api_comments_path(article_id: article.id)
        expect(response).to have_http_status(200)
      end
    end
  end

end