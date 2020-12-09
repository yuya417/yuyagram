require 'rails_helper'

RSpec.describe User, type: :model do

  context 'account_name、email、passwordが入力されている場合' do
    let!(:user) { create(:user)}
    it 'ユーザーを作成できる' do
      expect(user).to be_valid
    end
  end


  context 'account_nameが入力されていない場合' do
    user = User.create({
      account_name:  "",
      email: Faker::Internet.email,
      password: 'aaaaaa' 
    })
    it 'ユーザーを作成できない' do
      expect(user.errors.messages[:account_name][0]).to eq("has already been taken")
    end
  end


  context 'emailが入力されていない場合' do
    user = User.create({
      account_name:  Faker::Name.name,
      email: "",
      password: 'aaaaaa' 
    })
    it 'ユーザーを作成できない' do
      expect(user.errors.messages[:email][0]).to eq("can't be blank")
    end
  end


  context 'passwordが入力されていない場合' do
    user = User.create({
      account_name:  Faker::Name.name,
      email: Faker::Internet.email,
      password: '' 
    })
    it 'ユーザーを作成できない' do
      expect(user.errors.messages[:password][0]).to eq("can't be blank")
    end
  end


  context 'account_nameが同じ場合' do
    user = User.create({
      account_name: 'test',
      email: Faker::Internet.email,
      password: 'aaaaaa'
    })
    user2 = User.create({
      account_name: 'test',
      email: Faker::Internet.email,
      password: 'aaaaaa'
    })
    it 'ユーザーを作成できない' do
      expect(user2.errors.messages[:account_name][0]).to eq("has already been taken")
    end
  end


  context 'account_nameが同じ場合' do
    user = User.create({
      account_name: Faker::Name.name,
      email: 'testtest@example.com',
      password: 'aaaaaa'
    })
    user2 = User.create({
      account_name: Faker::Name.name,
      email: 'testtest@example.com',
      password: 'aaaaaa'
    })
    it 'ユーザーを作成できない' do
      expect(user2.errors.messages[:email][0]).to eq("has already been taken")
    end
  end


end
