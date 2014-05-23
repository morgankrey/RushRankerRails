namespace :db do
   desc "Fill database with sample data"
   task populate: :environment do
      User.create!(first_name: "Morgan",
                   last_name: "Krey",
                   email: "morgankrey@gmail.com",
                   password: "mfaan1",
                   password_confirmation: "mfaan1",
                   admin: true)
      30.times do |n|
         first_name = Faker::Name.first_name
         last_name = Faker::Name.last_name
         email = "example-#{n+1}@railstutorial.org"
         password = "password"
         User.create!(first_name: first_name,
                      last_name: last_name,
                      email: email,
                      password: password,
                      password_confirmation: password)
      end
      30.times do |n|
        first_name = Faker::Name.first_name
        last_name = Faker::Name.last_name
        email = "rushee-#{n+1}@example.com"
        phone_number = "8005551234"
        hometown = Faker::Address.city
        state = Faker::Address.state_abbr
        high_school = "High School"
        grade = "FR"
        score = rand(1000)
        rushee = Rushee.create!(first_name: first_name,
                                last_name: last_name,
                                preferred_name: first_name,
                                email: email,
                                phone_number: phone_number,
                                hometown: hometown,
                                state: state,
                                high_school: high_school,
                                grade: grade)
        rushee.score = Score.create!(score: score, rushee_id: rushee.id)
      end
      users = User.all(limit: 6)
      rushees = Rushee.all()
      5.times do |n|
        content = Faker::Lorem.sentence(1)
        users.each{ |user| rushees.each{ |rushee| rushee.comments.create!(content: content, user: user) } }
        puts n
      end
   end
end