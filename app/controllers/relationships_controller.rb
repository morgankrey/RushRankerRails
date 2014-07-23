class RelationshipsController < ApplicationController
   before_action :signed_in_user

   def create
      @rushee = Rushee.find(params[:relationship][:rushee_id])
      current_user.follow!(@rushee)
      redirect_to @rushee
   end

   def destroy
      @rushee = Relationship.find(params[:id]).followed
      current_user.unfollow!(@rushee)
      redirect_to @rushee
   end
end