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
      @random1 = Rushee.get_random_rushee
      @random2 = Rushee.get_random_rushee
      while (@random1 == @random2)
         @random2 = Rushee.get_random_rushee
      end
   end
end
