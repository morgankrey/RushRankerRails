require 'spec_helper'

describe "StaticPages" do

   let(:base_title) { "RushRanker" }

   describe "Home page" do
      before {visit '/static_pages/home'}

      it "should have the content 'RushRanker'" do
         expect(page).to have_content('RushRanker')
      end

      it "should have the title 'Home'" do
         expect(page).to have_title("#{base_title}")
      end

      it "should not have a custom page title" do
         expect(page).not_to have_title('| Home')
      end
   end

   describe "About page" do
      it "should have the content 'About'" do
         visit '/static_pages/about'
         expect(page).to have_content('About')
      end

      it "should have the title 'About'" do
         visit '/static_pages/about'
         expect(page).to have_title("#{base_title} | About")
      end
   end

   describe "Contact page" do
      it "should have the content 'Contact'" do
         visit '/static_pages/contact'
         expect(page).to have_content('Contact')
      end

      it "should have the title 'Contact'" do
         visit '/static_pages/contact'
         expect(page).to have_title("#{base_title} | Contact")
      end
   end
end
