class Comment < ActiveRecord::Base
   belongs_to :user
   belongs_to :rushee
   default_scope -> { order('created_at DESC') }
   validates :user_id, presence: true
   validates :rushee_id, presence: true
   validates :content, presence: true, length: { maximum: 500 }

   def self.get_all_recent_comments
      recents = Comment.all.sort_by(&:created_at).reverse[0..20]
   end

   def self.written_by_current
      current_user == self.user
   end
end
