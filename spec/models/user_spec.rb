require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Validations' do
    it 'will save if valid' do
      @test_user = User.new(name: 'andy', password: '12345', password_confirmation: '12345', email: 'a@gmail.com')
      @test_user.save
      expect(@test_user).to be_valid, @test_user.errors.full_messages
    end
    it 'will not save if password is nil' do
      @test_user = User.new(name: "andy", password: nil, password_confirmation: '12345', email: 'a@gmail.com')
      @test_user.save
      expect(@test_user).to_not be_valid
    end
    it 'will not save if confirm_password is wrong' do
      @test_user = User.new(name: "james", password: '12345', password_confirmation: '1234561', email: 'a@gmail.com')
      @test_user.save
      expect(@test_user).to_not be_valid
    end
    it 'will not save if name is nil' do
      @test_user = User.new(name: nil, password: "12345", password_confirmation: '12345', email: 'a@gmail.com')
      @test_user.save
      expect(@test_user).to_not be_valid
    end
    it 'will not save if email is nil' do
      @test_user = User.new(name: 'andy', password: "12345", password_confirmation: '12345', email: nil)
      @test_user.save
      expect(@test_user).to_not be_valid
    end
    it 'will not save if email is not unique' do
      @test_user1 = User.new(name: 'andy', password: "12345", password_confirmation: '12345', email: 'test@gmail.com')
      @test_user2 = User.new(name: 'andy2', password: "12345", password_confirmation: '12345', email: 'test@gmail.com')
      @test_user1.save
      @test_user2.save
      expect(@test_user1).to be_valid
      expect(@test_user2).to_not be_valid
    end

  end
  describe '.authenticate_with_credentials' do
    it 'will authencate user with email & pass' do
      @test_user = User.new(name: "andy", password: '12345', password_confirmation: '12345', email: 'a@gmail.com')
      @test_user.save
      @validates_user = User.authenticate_with_credentials('a@gmail.com', "12345")
      expect(@test_user).to eql(@validates_user)
    end
    it 'will authencate user with spaced-email & pass' do
      @test_user = User.new(name: "andy", password: '12345', password_confirmation: '12345', email: '   a@gmail.com')
      @test_user.save
      @validates_user = User.authenticate_with_credentials('a@gmail.com', "12345")
      expect(@test_user).to eql(@validates_user)
    end
    it 'will authencate user with spaced-email& capped ' do
      @test_user = User.new(name: "andy", password: '12345', password_confirmation: '12345', email: '   A@GMAIL.COM')
      @test_user.save
      @validates_user = User.authenticate_with_credentials('a@gmail.com', "12345")
      expect(@test_user).to eql(@validates_user)
    end
  end
end
