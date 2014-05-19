FactoryGirl.define do
   factory :user do
      first_name     "Morgan"
      last_name      "Krey"
      email          "example@user.com"
      password       "foobar"
      password_confirmation "foobar"
   end
end