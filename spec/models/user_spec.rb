require 'rails_helper'

RSpec.describe User, type: :model do
  before :all do
    User.create(first_name: 'John', last_name: 'Smith', email: 'test@test.com', password: 'test', password_confirmation: 'test')
  end
  
  describe 'Validations' do
    before :each do
      @user1 = User.new(first_name: 'John1', last_name: 'Smith', email: 'test1@test.com', password: 'testtest', password_confirmation: 'testtest')
    end

    it 'should create new user with correct inputs' do
      expect(@user1).to be_valid
    end
    it 'should not create new user if pw and pw confirmation do not match' do
      @user1.password = 'test1'
      expect(@user1).to_not be_valid
    end
    it 'should have unique email' do
      @user1.email = 'TEST@TEST.COM'
      expect(@user1).to_not be_valid
    end
    it 'should not have empty email field' do
      @user1.email = nil
      expect(@user1).to_not be_valid
    end
    it 'should not have empty first_name field' do
      @user1.first_name = nil
      expect(@user1).to_not be_valid
    end
    it 'should not have empty last_name field' do
      @user1.last_name = nil
      expect(@user1).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do 
    before :each do
      @user = User.find_by_email('test@test.com')
    end
    
    it 'should return user if email and password entered match' do  
      auth_success = User.authenticate_with_credentials('test@test.com', 'test')
      expect(auth_success).to eq(@user)
    end
    it 'should not return user if email and password do not match' do
      auth_fail = User.authenticate_with_credentials('test@test.com', 'testtest')
      expect(auth_fail).to_not eq(@user)
    end
    it 'should accept email input with white space before or after' do
      auth_whitespace_success = User.authenticate_with_credentials('     test@test.com     ', 'test')
      expect(auth_whitespace_success).to eq(@user)
    end
    it 'should have case insensitive login field for email' do
      auth_case_insensitive_success = User.authenticate_with_credentials('TEST@TEST.com', 'test')
      expect(auth_case_insensitive_success).to eq(@user)
    end
  end  
end