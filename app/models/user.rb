class User < ActiveRecord::Base
   before_save { self.email = email.downcase }

   validates :first_name, presence: true, length: { maximum: 15 }
   validates :last_name,  presence: true, length: { maximum: 15 }

   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
   validates :email, presence:   true,
                     format:     { with: VALID_EMAIL_REGEX },
                     uniqueness: { case_sensitive: false }

   has_secure_password
   validates :password, length: { minimum: 6 }

   has_attached_file :photo, styles: { medium: "300x300>",
                                       thumb: "100x100>" }
   validates_attachment_content_type :photo, content_type: /\Aimage/
   # Validate filename
   validates_attachment_file_name :photo, matches: [/png\Z/, /jpe?g\Z/]
   # Explicitly do not validate
   do_not_validate_attachment_file_type :photo
end
