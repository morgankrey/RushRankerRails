class Relationship < ActiveRecord::Base
   belongs_to :user, class_name: "User"
   belongs_to :rushee, class_name: "Rushee"
   validates :user_id, presence: true
   validates :rushee_id, presence: true
end
