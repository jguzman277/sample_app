# spec/features/user_sign_in_spec.rb

require 'rails_helper'

RSpec.feature "UserSignIns", type: :feature do
  
  # Create a user record in the test database before the test runs
  let!(:user) { create(:user, email: 'test@example.com', password: 'password123') }

  scenario "allows a registered user to sign in successfully" do
    # 1. Visit the sign-in page
    visit new_user_session_path

    # 2. Fill in the form with valid credentials
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    # 3. Click the "Log in" button
    click_button "Log in"

    # 4. Assert the user is redirected and sees a success message
    expect(page).to have_content("Signed in successfully.")
    expect(current_path).to eq(root_path)
  end

  scenario "shows an error message for an invalid password" do
    # 1. Visit the sign-in page
    visit new_user_session_path

    # 2. Fill in the form with an incorrect password
    fill_in "Email", with: user.email
    fill_in "Password", with: "wrongpassword"

    # 3. Click the "Log in" button
    click_button "Log in"
    
    # 4. Assert the user sees an error message and remains on the sign-in page
    expect(page).to have_content("Invalid Email or password.")
    expect(current_path).to eq(new_user_session_path)
  end

end