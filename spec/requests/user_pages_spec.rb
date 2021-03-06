require 'spec_helper'

describe "UserPages" do

   subject { page }

   describe "index" do
      let(:user) { FactoryGirl.create(:user) }
      let(:admin) { FactoryGirl.create(:admin) }
      before(:each) do
         sign_in user
         sign_in admin
         visit users_path
      end

      it { should have_title('All users') }
      it { should have_content('All users') }

      describe "pagination" do

         before(:all) { 30.times {FactoryGirl.create(:user) } }
         after(:all)  { User.delete_all }

         it { should have_selector('div.pagination') }

         it "should list each user" do
            User.paginate(page: 1).each do |user|
               expect(page).to have_selector('li',
                  text: "#{user.first_name} #{user.last_name}")
            end
         end
      end

      describe "delete links" do

         describe "as an admin user" do

            it { should have_link('delete', href: user_path(User.first)) }
            it "should be able to delete another user" do
               expect do
                  click_link('delete', match: :first)
               end.to change(User, :count).by(-1)
            end
            it { should_not have_link('delete', href: user_path(admin)) }
         end
      end
   end

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

   describe "edit" do
      let(:user) { FactoryGirl.create(:user) }
      before do
         sign_in user
         visit edit_user_path(user)
      end

      describe "page" do
         it { should have_content("Change your information") }
         it { should have_title("Edit user") }
      end

      describe "with invalid information" do
         before { click_button "Save changes" }

         it { should have_content('error') }
      end

      describe "with valid information" do
         let(:new_first_name) { "New "}
         let(:new_last_name)  { "Name" }
         let(:new_email)      { "new@example.com" }
         before do
            fill_in "First Name",            with: new_first_name
            fill_in "Last Name",             with: new_last_name
            fill_in "Email",                 with: new_email
            fill_in "Password",              with: user.password
            fill_in "Confirm Password",      with: user.password
            click_button "Save changes"
         end

         it { should have_title(new_email) }
         it { should have_selector('div.alert.alert-success') }
         it { should have_link('Sign out', href: signout_path) }
         specify { expect(user.reload.first_name).to eq new_first_name }
         specify { expect(user.reload.last_name).to eq new_last_name }
         specify { expect(user.reload.email).to eq new_email }
      end

      describe "forbidden attributes" do
         let(:params) do
            { user: { admin: true,
                      password: user.password,
                      password_confirmation: user.password } }
         end
         before do
            sign_in user, no_capybara: true
            patch user_path(user), params
         end
         specify { expect(user.reload).not_to be_admin }
      end
   end

   describe "authorization" do

      describe "for non-signed-in users" do
         let(:user) { FactoryGirl.create(:user) }

         describe "in the Users controller" do

            describe "visiting the edit page" do
               before { visit edit_user_path(user) }
               it { should have_title('Sign in') }
            end

            describe "submitting to the update action" do
               before { patch user_path(user) }
               specify { expect(response).to redirect_to(signin_path) }
            end
         end
      end
   end
end
