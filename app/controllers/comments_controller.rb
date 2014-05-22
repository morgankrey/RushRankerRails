class CommentsController < ApplicationController
   before_action :signed_in_user, only: [:create, :destroy]

   def create
      @comment = current_user.comments.build(rushee: get_rushee, content: _content)
      if @comment.save
         redirect_to rushee_path(get_rushee.id)
      else
         redirect_to root_url
      end
   end

   def destroy
   end

   private
      def get_rushee
         rushee = Rushee.find(params[:comment][:rushee_id])
      end

      def _content
         content = params[:comment][:content]
      end
end