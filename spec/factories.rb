FactoryGirl.define do
   factory :user do
      first_name     "Person"
      sequence(:last_name) { |n| "#{n}" }
      sequence(:email)     { |n| "person_#{n}@example.com"}
      password "foobar"
      password_confirmation "foobar"

      factory :admin do
         admin true
      end
   end

   factory :rushee do
      first_name     "Example"
      last_name      "Rushee"
      preferred_name "Example"
      phone_number   "8005551234"
      email          "example@rushee.com"
      hometown       "Anywhere"
      state          "CA"
      high_school    "Shitty School"
      grade          "FR"
      score          0
   end
end