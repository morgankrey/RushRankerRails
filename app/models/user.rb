class User < ActiveRecord::Base
   has_many :comments, dependent: :destroy
   has_many :relationships, dependent: :destroy
   has_many :followed_rushees, through: :relationships, source: :rushee
   before_save { self.email = email.downcase }
   before_create :create_remember_token

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

   def User.new_remember_token
      SecureRandom.urlsafe_base64
   end

   def User.encrypt(token)
      Digest::SHA1.hexdigest(token.to_s)
   end

   def following?(rushee)
      relationships.find_by(rushee_id: rushee.id)
   end

   def follow!(rushee)
      relationships.create!(rushee_id: rushee.id)
   end

   def unfollow!(rushee)
      relationships.find_by(rushee_id: rushee.id).destroy
   end

   private

      def create_remember_token
         self.remember_token = User.encrypt(User.new_remember_token)
      end
end
