require 'spec_helper'

describe "Rushee pages" do

   subject { page }

   describe "signup page" do

      before { visit new_rushee_path }
      let(:submit) { "Create rushee" }

      describe "with invalid information" do
         it "should not create a rushee" do
            expect { click_button submit }.not_to change(User, :count)
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
      end
   end
end
