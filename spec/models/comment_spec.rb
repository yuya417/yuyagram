require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }
  
  context '内容が入力されている場合' do
    let!(:comment) { create(:comment, user: user, article: article) }
    it 'コメントを保存できる' do
      expect(comment).to be_valid 
    end
  end

  context 'コメントが入力されていない場合' do
    let!(:comment) { build(:comment, user: user, article: article, content: "") }
    before do
      comment.save
    end
    it 'コメントを保存できない' do 
      expect(comment.errors.messages[:content][0]).to eq("can't be blank")
    end
  end

end
