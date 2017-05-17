require 'rails_helper'

RSpec.feature "User can sign in and view home page", type: :feature, js: true do
  before :each do 
    User.create(first_name: 'John', last_name: 'Smith', email: 'test@test.com', password: 'testtest', password_confirmation: 'testtest')
  end
  
  
  scenario 'User can log in' do
    visit login_path
    
    within 'form' do
      fill_in id: 'email', with: 'test@test.com'
      fill_in id: 'password', with: 'testtest'

      click_button 'Submit'
    end
    sleep(5)
    save_screenshot 'logged in.png'
    expect(page).to have_content('Logout')
  end  
end
