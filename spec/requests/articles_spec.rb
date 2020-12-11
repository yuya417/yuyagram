require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  let!(:user) { create(:user) }
  let!(:articles) { create_list(:article, 5, user: user) }
  
  describe 'GET /articles' do

    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it '200ステータスが返ってくる' do
        get articles_path
        expect(response).to have_http_status(200)
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        get articles_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
  end


  describe 'POST /articles' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it '記事が保存される' do
        article_params = FactoryBot.attributes_for(:article)
        post articles_path({article: article_params})
        expect(response).to have_http_status(302)
        expect(Article.last.content).to eq(article_params[:content])
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        article_params = FactoryBot.attributes_for(:article)
        post articles_path({article: article_params})
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end
