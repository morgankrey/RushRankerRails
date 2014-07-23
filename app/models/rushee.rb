class Rushee < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :reverse_relationships, class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :user
  has_one :score, dependent: :destroy
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

  has_attached_file :photo, styles: { medium: "300x300>",
                                     thumb: "100x100>" }

  validates_attachment_content_type :photo, content_type: /\Aimage/

  def self.get_random_rushee #for game
    rushee = Rushee.find(rand(1..(Rushee.count)))
  end

  def self.get_sorted_rushees #for index
    list = Rushee.all.sort_by(&:last_name)
  end
end
