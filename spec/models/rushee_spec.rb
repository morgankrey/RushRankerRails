require 'spec_helper'

describe Rushee do
   before { @rushee = Rushee.new(first_name: "Example",
                                 last_name: "User",
                                 preferred_name: "Example",
                                 phone_number: "8005551234",
                                 email: "rushee@example.com",
                                 hometown: "Anywhere",
                                 state: "CA",
                                 high_school: "Some School",
                                 grade: "FR",
                                 score: 0) }

   subject { @rushee }

   subject { @rushee }

   it { should respond_to(:first_name) }
   it { should respond_to(:last_name) }
   it { should respond_to(:preferred_name) }
   it { should respond_to(:phone_number) }
   it { should respond_to(:email) }
   it { should respond_to(:hometown) }
   it { should respond_to(:state) }
   it { should respond_to(:high_school) }
   it { should respond_to(:grade) }
   it { should respond_to(:score) }

   describe "first name" do
      describe "is not present" do
         before { @rushee.first_name = "" }
         it { should_not be_valid }
      end

      describe "is too short" do
         before { @rushee.first_name = "a" }
         it { should_not be_valid }
      end

      describe "is too long" do
         before { @rushee.first_name = "a"*21 }
         it { should_not be_valid }
      end
   end

   describe "last name" do
      describe "is not present" do
         before { @rushee.last_name = "" }
         it { should_not be_valid }
      end

      describe "is too short" do
         before { @rushee.last_name = "a" }
         it { should_not be_valid }
      end

      describe "is too long" do
         before { @rushee.last_name = "a"*21 }
         it { should_not be_valid }
      end
   end

   describe "when email is not present" do
      before { @rushee.email = '' }
      it { should_not be_valid }
   end

   describe "when email format is invalid" do
      it "should be invalid" do
         addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
         addresses.each do |invalid_address|
            @rushee.email = invalid_address
            expect(@rushee).not_to be_valid
         end
      end
   end

   describe "when email format is valid" do
      it "should be valid" do
         addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
         addresses.each do |valid_address|
            @rushee.email = valid_address
            expect(@rushee).to be_valid
         end
      end
   end

   describe "when email address is already taken" do
      before do
         rushee_with_same_email = @rushee.dup
         rushee_with_same_email.email = @rushee.email.upcase
         rushee_with_same_email.save
      end

      it { should_not be_valid }
   end

   describe "when score is not present" do
      before { @rushee.score = nil }
      it { should_not be_valid }
   end
end
