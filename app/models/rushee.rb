class Rushee < ActiveRecord::Base
   has_many :comments, dependent: :destroy
   before_save { self.email = email.downcase }

   validates :first_name, presence: true,
                          length: { minimum: 2, maximum: 20 }
   validates :last_name,  presence: true,
                          length: { minimum: 2, maximum: 20 }

   validates :phone_number, length: { is: 10 }

   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
   validates :email, presence: true,
                     format: { with: VALID_EMAIL_REGEX },
                     uniqueness: { case_sensitive: false }

   validates :score, presence: true

   has_attached_file :photo, styles: { medium: "300x300>",
                                       thumb: "100x100>" }
   validates_attachment_content_type :photo, content_type: /\Aimage/
   # Validate filename
   validates_attachment_file_name :photo, matches: [/png\Z/, /jpe?g\Z/]
   # Explicitly do not validate
   do_not_validate_attachment_file_type :photo

   def self.get_random_rushee #for game
      rushee = Rushee.find(rand(1..(Rushee.count)))
   end
end
