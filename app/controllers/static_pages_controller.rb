class StaticPagesController < ApplicationController

   def home
      @comments = Comment.get_all_recent_comments
      @random = Rushee.get_random_rushee
   end

   def about
   end

   def contact
   end

   def game
   end

end
