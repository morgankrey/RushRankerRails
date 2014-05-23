class ScoresController < ApplicationController
   before_action :signed_in_user, only: [:update]

   def update
      @score = Score.find(params[:id])
      @score.score += 1
      @score.save
      redirect_to game_path
   end

   private
      def score_params
         params.require(:score).permit(:score, :rushee_id)
      end
end