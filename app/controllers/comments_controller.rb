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
      rushee = Rushee.find(Comment.find(params[:id])[:rushee_id])
      Comment.find(params[:id]).destroy
      flash[:success] = "Comment deleted"
      redirect_to rushee_path(rushee.id)
   end

   private
      def get_rushee
         rushee = Rushee.find(params[:comment][:rushee_id])
      end

      def _content
         content = params[:comment][:content]
      end

      def admin_user
         flash[:alert]="Not authorized" unless current_user.admin?
      end
end