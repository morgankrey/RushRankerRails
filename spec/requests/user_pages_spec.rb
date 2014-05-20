require 'spec_helper'

describe "UserPages" do

   subject { page }

   describe "profile page" do
      let(:user) { FactoryGirl.create(:user) }
      before { visit user_path(user) }

      it { should have_content(user.first_name) }
      it { should have_content(user.last_name) }
      it { should have_title(user.email) }
   end

   describe "signup page" do
      before { visit signup_path }
      let(:submit) { "Create my account" }

      it { should have_content('Sign up') }
      it { should have_title(full_title('Sign up')) }

      describe "with invalid information" do
         it "should not create a user" do
            expect { click_button submit }.not_to change(User, :count)
         end

         describe "after submission" do
            before { click_button submit }

            it { should have_title('Sign up') }
            it { should have_content('error') }
         end
      end

      describe "with valid information" do
         before do
            fill_in "First Name",            with: "Example"
            fill_in "Last Name",             with: "User"
            fill_in "Email",                 with: "example@user.com"
            fill_in "Password",              with: "foobar"
            fill_in "Confirm Password",      with: "foobar"
         end

         it "should create a user" do
            expect { click_button submit }.to change(User, :count).by(1)
         end

         describe "after saving the user" do
            before { click_button submit }
            let(:user) { User.find_by(email: 'example@user.com') }

            it { should have_link('Sign out') }
            it { should have_title(user.email) }
            it { should have_selector('div.alert.alert-success', text: 'Welcome') }
         end
      end
   end
end
