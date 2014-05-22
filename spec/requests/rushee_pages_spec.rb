require 'spec_helper'

describe "Rushee pages" do
   let(:user) { FactoryGirl.create(:user) }
   before do
      sign_in user
      visit root_url
   end

   subject { page }

   describe "signup page" do

      before { visit new_rushee_path }
      let(:submit) { "Create rushee" }

      describe "with invalid information" do
         it "should not create a rushee" do
            expect { click_button submit }.not_to change(Rushee, :count)
         end

         describe "after submission" do
            before { click_button submit }

            it { should have_title('Add rushee') }
            it { should have_content('error') }
         end
      end

      describe "with valid information" do
         before do
            fill_in "First Name",            with: "Example"
            fill_in "Last Name",             with: "Rushee"
            fill_in "Preferred Name",        with: "Example"
            fill_in "Phone Number",          with: "8005551234"
            fill_in "Email",                 with: "rushee@example.com"
            fill_in "Hometown",              with: "Anywhere"
            select  "California",            from: "State"
            fill_in "High School",           with: "Some School"
            select  "Freshman",              from: "Grade"
         end

         it "should create a rushee" do
            expect{ click_button submit }.to change(Rushee, :count).by(1)
         end

         describe "after saving the user" do
            before { click_button submit }
            let(:rushee) { Rushee.find_by(email: 'rushee@example.com') }

            it { should have_title("#{rushee.first_name} #{rushee.last_name}") }
            it { should have_selector('div.alert.alert-success', text: 'Success') }
         end
      end
   end

   describe "edit" do
      let(:rushee) { FactoryGirl.create(:rushee) }
      before { visit edit_rushee_path(rushee) }

      describe "page" do
         it { should have_content("Update rushee profile") }
         it { should have_title("Edit rushee") }
      end

      describe "with invalid information" do
         before do
            fill_in "First Name",         with: "a"
            click_button "Save changes"
         end

         it { should have_content('error') }
      end

      describe "with valid information" do
            let(:new_first_name) { "New" }
            let(:new_last_name)  { "Name" }
         before do
            fill_in "First Name",       with: new_first_name
            fill_in "Last Name",        with: new_last_name
            click_button "Save changes"
         end

         it { should have_title("#{new_first_name} #{new_last_name}") }
         it { should have_selector('div.alert.alert-success') }
         it { should have_link('Sign out', href: signout_path) }
         specify { expect(rushee.reload.first_name).to eq new_first_name }
         specify { expect(rushee.reload.last_name).to eq new_last_name }
      end
   end
end
