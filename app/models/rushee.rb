class Rushee < ActiveRecord::Base
   before_save { self.email = email.downcase }

   validates :first_name, presence: true,
                          length: { minimum: 2, maximum: 20 }
   validates :last_name,  presence: true,
                          length: { minimum: 2, maximum: 20 }

   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
   validates :email, presence: true,
                     format: { with: VALID_EMAIL_REGEX },
                     uniqueness: { case_sensitive: false }

   validates :score, presence: true
end
