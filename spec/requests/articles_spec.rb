require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  let!(:user) { create(:user) }
  let!(:articles) { create_list(:article, 5, user: user) }
  
  # describe 'GET /articles' do
  #   it '302ステータスが返ってくる' do
  #     get articles_path
  #     expect(response).to have_http_status(302)
  #   end
  # end

  describe 'POST /articles' do
    context 'ログインしている場合' do
      before do
        sign_in user
        # @article = FactoryBot.build(:article)
        # @article.images = fixture_file_upload('app/assets/images/Ellipse.png')
      end

      it '記事が保存される' do
        article_params = FactoryBot.attributes_for(:article)
        post articles_path({article: article_params})
        expect(response).to have_http_status(302)
        expect(Article.last.content).to eq(article_params[:content])
      end
    end
  end

end
