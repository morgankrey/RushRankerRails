class Score < ActiveRecord::Base
   belongs_to :rushee
   validates :score, presence: true
end
